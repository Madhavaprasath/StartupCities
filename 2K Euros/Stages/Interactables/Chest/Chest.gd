extends StaticBody2D

export(String) var id
export(bool) var open
export(int) var coins = 10

onready var sprite = $Sprite
onready var hint = $Hint
onready var anim = $AnimationPlayer

const OPEN_FRAME = 6
const CLOSE_FRAME = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if open:
		sprite.frame = OPEN_FRAME
	else:
		sprite.frame = CLOSE_FRAME
	pass # Replace with function body.


func trigger():
	anim.play("open")


func _on_Trigger_body_entered(body):
	if body.name == "Player" and !open:
		if Global.collected_keys.find(id) > -1:
			hint.text = "Press [E] to Open"
			body.player_interactables.append(self)
		hint.show()
	pass # Replace with function body.


func _on_Trigger_body_exited(body):
	if body.name == "Player":
		body.player_interactables.clear() # there should be 1 interactable at a time
	hint.hide()
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	# pop something here and add to the player
	Global.coins += coins
	open = false
	hint.hide()
	pass # Replace with function body.
