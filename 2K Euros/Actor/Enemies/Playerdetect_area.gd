extends Area2D

var player=null

func get_player():
	return player!=null



func _on_Playerdetect_area_body_entered(body):
	player=body


func _on_Playerdetect_area_body_exited(body):
	player=null
