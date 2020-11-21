extends Node

# Singleton

var coins = 0
var collected_keys = []
var stage_scns = {
	"stage1": "res://Stages/Stage2/Stage1.tscn",
	"stage2": "res://Stages/Stage2/Stage2.tscn"
}

func navigate_to_next_stage(stage_id):
	get_tree().change_scene(stage_scns[stage_id])
