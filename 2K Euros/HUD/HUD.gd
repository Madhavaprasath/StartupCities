extends Node2D

var time_start = 0
var time_now = 0

onready var floor_lbl = $Floor
onready var floor_number_lbl = $Number
onready var title_lbl = $Title
onready var time_lbl = $Time
onready var anim = $AnimationPlayer

func _ready():
	time_start = OS.get_unix_time()
	set_process(false)


func start(floor_number, title = ""):
	floor_number_lbl.text = floor_number
	title_lbl.text = title
	anim.play("show_floor")


func _process(delta):
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	var milliseconds = elapsed / 1000
	var str_elapsed = "%02d : %02d" % [minutes, seconds]
	
	time_lbl.text = str_elapsed


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "show_floor":
		EventManager.emit_signal("start_stage")
		time_start = OS.get_unix_time()
		
		floor_lbl.hide()
		floor_number_lbl.hide()
		title_lbl.hide()
		
		set_process(true)
	pass # Replace with function body.
