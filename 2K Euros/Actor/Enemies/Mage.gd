extends "res://Actor/Enemies/Enemy.gd"


var bullet_scene=preload("res://Actor/Fireball/Fireball.tscn")

var can_shoot=false
func _physics_process(delta):
	._physics_process(delta)
func _ready():
	randomize()

