extends CanvasLayer

func _input(event):
	if event.is_action_pressed("esc"):
		get_tree().paused=not get_tree().paused


func _on_Button_pressed():
	get_tree().paused=false


func _on_Button2_pressed():
	get_tree().change_scene("res://Scenes/Mainmaenu.tscn")
