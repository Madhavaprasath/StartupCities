extends Node2D

export var wader_range=32

onready var target_position=global_position
onready var start_position=global_position

func _ready():
	update_target_position()

func update_target_position():
	var target_Vector=Vector2(rand_range(-wader_range,wader_range),rand_range(-wader_range,wader_range))
	target_position=start_position+target_Vector
func check_for_timer():
	return get_node("Timer").time_left

func set_duration(duration):
	get_node("Timer").start(duration)


func _on_Timer_timeout():
	update_target_position()
