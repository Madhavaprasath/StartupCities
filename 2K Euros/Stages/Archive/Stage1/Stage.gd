extends Node2D

var player_scn = preload("res://Actor/Player/Player.tscn")

onready var player_spawn_point = $PlayerSpawnPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	
	AudioManager.change_state("stage")
	
	var player = player_scn.instance()
	add_child(player)
	
	player.position = player_spawn_point.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
