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
			if parent.groupname=="Player":
				parent.animation_player.play("Player_Idle")
			elif parent.groupname=="Cat":
				parent.animation_player.play("Cat_Idle")
			elif parent.groupname=="Org":
				parent.animation_player.play("Org_Idle")
			else:
				parent.animation_player.play("Mage_Idle")
		"Run":
			if parent.groupname=="Player":
				parent.animation_player.play("Player_Run")
			elif parent.groupname=="Cat":
				parent.animation_player.play("Cat_Run")
			elif parent.groupname=="Org":
				parent.animation_player.play("Org_Run")
			else:
				parent.animation_player.play("Mage_Run")
func _unhandled_input(event):
	if event.is_action_pressed("click"):
		if current_state=="Idle"&&parent.attacking==false:
			if parent.groupname=="Cat"||parent.groupname=="Org"&&parent.groupname!="Player":
				match parent.groupname:
					"Cat":
						parent.animation_player.play("Cat_Attack")
					"Org":
						parent.animation_player.play("Org_Attack")
			elif parent.groupname=="Mage":
				parent.animation_player.play("Mage_Attack")
