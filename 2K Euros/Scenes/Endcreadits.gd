extends Node2D

func _ready():
	AudioManager.change_state("end")
	
func _on_AnimationPlayer_animation_finished(anim_name):
	yield(get_tree().create_timer(5),"timeout")
	get_tree().change_scene("res://Scenes/Mainmaenu.tscn")
