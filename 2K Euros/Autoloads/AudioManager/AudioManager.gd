extends Node

var state
var fade_time

onready var tween = $Tween

func _ready():
	print("in music ready function")
	state = "normal"


func change_state(new_state):
	state = new_state
	
	$Tween.stop_all()
	var audio_to_play: AudioStreamPlayer
	
	match new_state:
		"menu":
			audio_to_play = $BGMS/MainMenu
		"stage":
			audio_to_play = $BGMS/Stage
		"end":
			audio_to_play = $BGMS/End
		"none":
			fade_current()
			return

	for child in $BGMS.get_children():
		if child != audio_to_play:
			_set_fade_out(child) 
	$Tween.start() # Actually starts fading out
	
	if audio_to_play:
		if audio_to_play.is_playing():
			return
		else:
			audio_to_play.play()


func fade_current():
	print("fading current music")
	$Tween.stop_all()
	for child in $BGMS.get_children():
		_set_fade_out(child)
	$Tween.start() # Actually starts fading out
	state = "none"


func _set_fade_out(audio_player : AudioStreamPlayer):
	if !audio_player.is_playing():
		return
	
	$Tween.interpolate_property(audio_player, "volume_db", audio_player.volume_db, -70, fade_time,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)


func _on_Tween_tween_all_completed():
	match state:
		"menu":
			$BGMS/Stage.stop()
			$BGMS/End.stop()
		"stage":
			$BGMS/MainMenu.stop()
			$BGMS/End.stop()
		"end":
			$BGMS/MainMenu.stop()
			$BGMS/Stage.stop()
		"none":
			$BGMS/MainMenu.stop()
			$BGMS/Stage.stop()
			$BGMS/End.stop()
