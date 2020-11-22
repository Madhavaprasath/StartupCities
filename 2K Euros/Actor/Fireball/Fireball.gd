extends KinematicBody2D
class_name Fireball

var from_player = ""
var speed = 150
var velocity = Vector2()

func start(pos, dir, is_player = false):
	from_player = is_player
	$Sprite.scale.x = -1
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider is Vines and from_player:
			collision.collider.burn()
		queue_free()
