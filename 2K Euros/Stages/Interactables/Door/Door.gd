extends Area2D

export(String) var id
export(bool) var open

onready var sprite = $Sprite
onready var hint = $Hint
onready var anim = $AnimationPlayer

const OPEN_FRAME = 3
const CLOSE_FRAME = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if open:
		sprite.frame = OPEN_FRAME
	else:
		sprite.frame = CLOSE_FRAME
	pass # Replace with function body.


func _on_Door_body_entered(body):
	print("door enter: ", body.name)
	if body.name == "Player":
		if Global.collected_keys.find(id) > -1:
			anim.play("open")
		else:
			hint.show()
	pass # Replace with function body.


func _on_Door_body_exited(body):
	print("door exit: ", body.name)
	hint.hide()
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	Global.navigate_to_next_stage(id)
	pass # Replace with function body.
