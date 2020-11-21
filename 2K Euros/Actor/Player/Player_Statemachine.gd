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
func state_logic(delta):
	parent.apply_movement()
	parent.Flip_character()
func transition(delta):
	match current_state:
		"Idle":
			if parent.move_vector!=Vector2(0,0):
				return states[2]
		"Run":
			if parent.move_vector==Vector2(0,0):
				return states[1]
	return null
