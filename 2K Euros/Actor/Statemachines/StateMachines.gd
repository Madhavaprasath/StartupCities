extends Node
class_name Statemachine

var parent=get_parent()

#states 
var state={}
var current_state 

func _physics_process(delta):
	state_logic(delta)
	var state=transition(delta)
	if state!=null:
		animation(state)
func state_logic(delta):
	pass
func transition(delta):
	return null
func animation(state):
	pass
