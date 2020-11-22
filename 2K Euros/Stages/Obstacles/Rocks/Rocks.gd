extends StaticBody2D
class_name Rocks

onready var anim_sprites = $AnimatedSprite
onready var hint = $Hint
var anim = "idle"

func smash():
	anim = "broken"
	anim_sprites.play(anim)

func _on_AnimatedSprite_animation_finished():
	if anim == "broken":
		queue_free()
	pass # Replace with function body.
