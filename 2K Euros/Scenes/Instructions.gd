extends Node2D

func _ready():
	AudioManager.change_state("instruction")

func _on_Back_pressed():
	get_tree().change_scene("res://Scenes/Mainmaenu.tscn")
	pass # Replace with function body.
