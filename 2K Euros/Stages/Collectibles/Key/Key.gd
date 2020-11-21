extends Area2D

export(String) var is_for
export(bool) var collectible

onready var collision = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	collision.disabled = !collectible
	pass # Replace with function body.

func _on_Key_body_entered(body):
	if body.name == "Player":
		Global.collected_keys.append(is_for)
		# collect sounds
		queue_free()
	pass # Replace with function body.
