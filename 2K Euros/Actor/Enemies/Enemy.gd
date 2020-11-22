extends KinematicBody2D


var group_name="Enemy"
const accerlation=200
enum {
	Idle,
	wander,
	Chase,
	attack
}
var stats={
	"Health":20,
	"damage":4,
	"Speed":200
}
var velocity=Vector2()
export (bool)var wanderable=true
onready var Attack_Zone :Area2D=get_node("PlayerActtack Zone")
onready var Wander_controller:Node2D=get_node("WanderControler")
onready var Body:Node2D=get_node("Body")
onready var animation_player:AnimationPlayer=get_node("Body/AnimationPlayer")
onready var player_detect_zone:Area2D=get_node("Playerdetect_area")
var state=attack
var attacking=false
func _ready():
	randomize()

func _physics_process(delta):
	match state:
		Idle:
			velocity=velocity.move_toward(Vector2.ZERO,accerlation*delta)
			check_attack_player()
			check_chase_player()
			if wanderable==true:
				if Wander_controller.check_for_timer()==0:
					state=shuffle_array([Idle,wander])
					Wander_controller.set_duration(rand_range(1,3))
		wander:
			if wanderable==true:
				check_attack_player()
				check_chase_player()
				if Wander_controller.check_for_timer()==0:
					state=shuffle_array([Idle,wander])
					Wander_controller.set_duration(rand_range(1,3))


				var direction=global_position.direction_to(Wander_controller.target_position)
				velocity=velocity.move_toward(direction*stats["Speed"],accerlation*delta)
			
				if global_position.distance_to(Wander_controller.target_position)<=4:
					state=shuffle_array([Idle,wander])
					Wander_controller.set_duration(rand_range(1,3))

		Chase:
				check_attack_player()
				var player=player_detect_zone.player
				if player!=null:
					var direction=(global_position.direction_to(player.global_position)).normalized()
					velocity=velocity.move_toward(direction*stats["Speed"],accerlation*delta)
				else:
					state=shuffle_array([Idle,wander])
		attack:
			var player=Attack_Zone.player
			if player!=null:
				velocity=Vector2(0,0)
			else:
				return
	
	velocity=move_and_slide(velocity)
	flip_character()
	animation(state)



func check_attack_player():
	if Attack_Zone.check_player()==true:
		state=attack
func check_chase_player():
	if player_detect_zone.get_player()==true:
		state=Chase
func shuffle_array(arrays):
	arrays.shuffle()
	return arrays.pop_front()
func attack():
	attacking = true
func flip_character():
		if velocity.x>0:
			Body.scale.x=1
			$EnemyHitbox.scale.x=1
		elif velocity.x<0:
			Body.scale.x=-1
			$EnemyHitbox.scale.x=-1

func animation(states):
	var anim=""
	if states==Idle:
		anim="Idle"
	elif states in [Chase,wander]:
		anim="Run"
	elif states==attack:
		anim="Attack"
	if animation_player.current_animation !=anim:
		animation_player.play(anim)
