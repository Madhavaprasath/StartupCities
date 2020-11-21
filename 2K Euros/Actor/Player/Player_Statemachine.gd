extends "res://Actor/Statemachines/StateMachines.gd"

func _init():
	state={
		1:"Idle",
		2:"Run",
		3:"Attack"
	}
	current_state=state[1]
func state_logic(delta):
	parent.apply_movement()
	parent.Flip_character()
