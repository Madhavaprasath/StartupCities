extends Node2D

var player
var player_scn = preload("res://Actor/Player/Player.tscn")
onready var player_spawn_point = $PlayerSpawnPoint
onready var HUD = $HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	EventManager.connect("start_stage", self, "_on_start_stage")
	EventManager.connect("move_hud", self, "_on_move_hud")
	AudioManager.change_state("stage")
	
	player = player_scn.instance()
	add_child(player)
	
	player.position = player_spawn_point.position
	HUD.start("2", "Title here...")
	pass # Replace with function body.

func _on_start_stage():
	player.can_move = true

func _on_move_hud(cam_snap_pos):
	HUD.position = cam_snap_pos
