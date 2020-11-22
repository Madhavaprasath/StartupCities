extends StaticBody2D

export(String) var id
export(bool) var open
export(bool) var is_next_stage

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


func _on_AnimationPlayer_animation_finished(anim_name):
	if is_next_stage:
		Global.navigate_to_next_stage(id)
	else:
		queue_free()
	pass # Replace with function body.


func _on_Trigger_body_entered(body):
	print("door enter: ", body.name)
	if body.name == "Player":
		if Global.collected_keys.find(id) > -1:
			anim.play("open")
		else:
			hint.show()
	pass # Replace with function body.


func _on_Trigger_body_exited(body):
	hint.hide()
	pass # Replace with function body.
