extends StaticBody2D
class_name Vines

onready var anim_sprites = $AnimatedSprite
onready var hint = $Hint
var anim = "idle"

func burn():
	anim = "burn"
	anim_sprites.play(anim)

func _on_AnimatedSprite_animation_finished():
	if anim == "burn":
		queue_free()
	pass # Replace with function body.
