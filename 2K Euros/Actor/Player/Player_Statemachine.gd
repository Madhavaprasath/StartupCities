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
func animation(state):
	match state:
		"Idle":
			parent.Player.get_node("AnimationPlayer").play("Idle")
		"Run":
			parent.Player.get_node("AnimationPlayer").play("Run")
func _unhandled_input(event):
	if event.is_action_pressed("click"):
		if current_state=="Idle"&&parent.attacking==false:
			if parent.current_outfit==parent.Bow_outfit:
				parent.attacking=true
				#shoot
				yield(get_tree().create_timer(0.5),"timeout")
				parent.attacking=false
			else:
				parent.attacking=true
				print("hi")
				yield(get_tree().create_timer(0.5),"timeout")
				parent.attacking=false
