extends KinematicBody2D

# we can just call it with or stats



var move_vector
var Velocity=Vector2()
var fliped 
var attacking = false
var groupname="Player"
var previous_group_name=null
#cast variables
onready var Body:Node2D=get_node("Body")




#stats
var stats={
	"health":100,
	"Move_speed":150,
	"attack_damage":20
}

var player_interactables = []


func _ready():
	#Check_for_outfit()
	pass
func apply_movement():
	var y=-int(Input.is_action_pressed("Up"))+int(Input.is_action_pressed("Down"))
	var x=int(Input.is_action_pressed("Right"))-int(Input.is_action_pressed("Left"))
	move_vector=Vector2(x,y)
	Velocity.x=lerp(Velocity.x,stats["Move_speed"]*move_vector.x,0.1)
	Velocity.y=lerp(Velocity.y,stats["Move_speed"]*move_vector.y,0.1)
	Velocity=move_and_slide(Velocity,Vector2.UP)
	
	var interact = Input.is_action_just_pressed("Interact")
	if interact and player_interactables.size() > 0 :
		var interactable = player_interactables[0]
		interactable.trigger()


func Flip_character():
	var mouse_position=get_local_mouse_position()
	if mouse_position.x>0:
		fliped=1
	elif mouse_position.x<0:
		fliped=-1
	else:
		fliped=0
	if fliped!=0:
		Body.scale.x=fliped



func getting_damaged(area):
	stats["health"]-=area.stats["damage"]
	if stats["health"]==0:
		previous_group_name=groupname
		groupname=area.groupname


func _on_Player_hurtBox_area_entered(area):
	getting_damaged(area)
