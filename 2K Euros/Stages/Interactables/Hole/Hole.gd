extends Area2D

export(bool) var open
export(String) var next_hole

onready var sprite = $Sprite
onready var anim = $AnimationPlayer

func _on_Hole_body_entered(body):
	if body.name == "Player":
		body.player_interactables.append(self)
	pass # Replace with function body.


func _on_Hole_body_exited(body):
	body.player_interactables.clear()
	pass # Replace with function body.
