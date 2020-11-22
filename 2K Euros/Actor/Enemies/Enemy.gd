extends KinematicBody2D


var group_name="Enemy"
const accerlation=200
enum {
	Idle,
	wander,
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
var state=Idle
func _ready():
	randomize()
func _physics_process(delta):
	print(state)
	flip_character()
	match state:
		Idle:
			velocity=velocity.move_toward(Vector2.ZERO,accerlation*delta)
			seek_player()
			if wanderable==true:
				if Wander_controller.check_for_timer()==0:
					state=shuffle_array([Idle,wander])
					Wander_controller.set_duration(rand_range(1,3))
		wander:
			if wanderable==true:
				seek_player()
				if Wander_controller.check_for_timer()==0:
					state=shuffle_array([Idle,wander])
					Wander_controller.set_duration(rand_range(1,3))


				var direction=global_position.direction_to(Wander_controller.target_position)
				velocity=velocity.move_toward(direction*stats["Speed"],accerlation*delta)
			
				if global_position.distance_to(Wander_controller.target_position)<=4:
					state=shuffle_array([Idle,wander])
					Wander_controller.set_duration(rand_range(1,3))
		attack:
			var player=Attack_Zone.player
			print(player)
			if player!=null:
				attack()
			if player==null:
				state=shuffle_array([Idle,wander])
	velocity=move_and_slide(velocity)
	animation(velocity)
func seek_player():
	if Attack_Zone.check_player()==true:
		state=attack
func shuffle_array(arrays):
	arrays.shuffle()
	return arrays.pop_front()
func attack():
	pass
func flip_character():
	if velocity.x>0:
		Body.scale.x=1
	elif velocity.x<0:
		Body.scale.x=-1
func animation(velocity:Vector2):
	var anim=""
	if velocity==Vector2.ZERO:
		anim='Idle'
	elif velocity!=Vector2.ZERO:
		anim='Run'
	if animation_player.current_animation !=anim:
		animation_player.play(anim)
