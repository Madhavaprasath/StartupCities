extends "res://Actor/Statemachines/StateMachines.gd"

func _init():
	state={
		1:"Idle",
		2:"Run",
		"Attack":{
			1:"meele",
			2:"Bow"
		},
		3:"staggered"
	}
	current_state=state[1]
func state_logic(delta):
	parent.apply_movement()
	parent.Flip_character()
func transition(delta):
	
	return null
