extends KinematicBody2D


enum {
	Idle,
	wander,
	Chase,
	attack
}
var stats={
	"Health":20,
	"damage":4,
	"Speed":100
}
var velocity=Vector2()


onready var Attack_Zone :Area2D=get_node("PlayerActtack Zone")
var state=Idle
func _physics_process(delta):
	match state:
		Idle:
			velocity=lerp(velocity,0,0.2)
		wander:
			pass
		attack:
			var player=Attack_Zone.player
			if player!=null:
				attack()
func seek_player():
	if Attack_Zone.check_player()==true:
		state=attack
func shuffle_array(arrays):
	arrays.shuffle()
	return arrays.pop_front()
func attack():
	print("i will kll you ")
