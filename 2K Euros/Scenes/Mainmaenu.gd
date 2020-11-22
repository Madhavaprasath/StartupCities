extends Control


func _ready():
	AudioManager.change_state("menu")


func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Instruction_pressed():
	get_tree().change_scene("res://Scenes/Instructions.tscn")
	pass # Replace with function body.


func _on_Play_pressed():
	get_tree().change_scene("res://Stages/Stage1/Stage1.tscn")
	pass # Replace with function body.
