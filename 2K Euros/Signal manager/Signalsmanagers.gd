extends Node

signal on_player_character_change(groupname)


func on_player_change(groupname):
	emit_signal("on_player_character_change",groupname)
