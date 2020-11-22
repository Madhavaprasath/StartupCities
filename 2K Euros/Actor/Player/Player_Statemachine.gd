extends "res://Actor/Statemachines/StateMachines.gd"


func _init():
	states={
		1:"Idle",
		2:"Run",
		"Attack":{
			1:"meele",
			2:"Bow"
		},
		3:"staggered"
	}
	current_state=states[1]

func _ready():
	pass

func state_logic(delta):
	parent.camera_snap()
	if !parent.can_move: return
	
	var movement = parent.apply_movement()
	parent.flip_character(movement)
	parent.rotate_aim()
	parent.camera_snap()


func transition(delta):
	match current_state:
		"Idle":
			if parent.move_vector!=Vector2(0,0):
				parent.current_animation = "Run"
				return states[2]
		"Run":
			if parent.move_vector==Vector2(0,0):
				parent.current_animation = "Idle"
				return states[1]
	return null

func animation(state):
	parent.animation_player.play(parent.groupname + "_" + state)


func _unhandled_input(event):
	if event.is_action_pressed("click"):
		match parent.groupname:
			"Cat":
				parent.animation_player.play("Cat_Attack")
			"Ogre":
				parent.animation_player.play("Ogre_Attack")
				parent.smash()
			"Mage":
				parent.animation_player.play("Mage_Attack")
				parent.shoot()
