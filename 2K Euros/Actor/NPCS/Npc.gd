extends StaticBody2D

export(String) var mob = "Cat"
onready var attack = $Attack
onready var idle = $Idle
onready var anim = $AnimationPlayer
onready var hint = $Hint

func _ready():
	attack.visible = false
	idle.visible = true


func attack():
	anim.play("attack")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		EventManager.emit_signal("morph", mob)
		queue_free()
	pass # Replace with function body.


func _on_Trigger_body_entered(body):
	if body.name == "Player":
		attack.flip_h = body.position.x < position.x
		idle.flip_h = body.position.x < position.x
		body.player_morphable = self
		hint.show()
	pass # Replace with function body.


func _on_Trigger_body_exited(body):
	if body.name == "Player":
		body.player_morphable = null
		hint.hide()
	pass # Replace with function body.
