extends KinematicBody2D

var parent = ""
var speed = 150
var velocity = Vector2()

func start(pos, dir):
	$Sprite.scale.x = -1
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	# check collision of the enemy
