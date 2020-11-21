extends KinematicBody2D

# we can just call it with or stats
const Move_speed=250



var move_vector
var Velocity=Vector2()
var fliped 


#cast variables
onready var Player_outfit:Node2D= get_node("Body/Player_outfit")
onready var Enemy_outfit:Node2D=get_node("Body/Enemy outfit")
onready var Enemy_outfit2:Node2D=get_node("Body/Enemy outfit2")
onready var Enemy_outfit3:Node2D=get_node("Body/Enemy outfit3")
onready var Body:Node2D=get_node("Body")

enum{
	player,
	Enemy1,
	Enemy2,
	Enemy3
}
var current_outfit=player
func _ready():
	#Check_for_outfit()
	pass
func _physics_process(delta):
	apply_movement()
	Flip_character()
func apply_movement():
	var y=-int(Input.is_action_pressed("Up"))+int(Input.is_action_pressed("Down"))
	var x=int(Input.is_action_pressed("Right"))-int(Input.is_action_pressed("Left"))
	move_vector=Vector2(x,y)
	Velocity.x=lerp(Velocity.x,Move_speed*move_vector.x,0.2)
	Velocity.y=lerp(Velocity.y,Move_speed*move_vector.y,0.2)
	Velocity=move_and_slide(Velocity,Vector2.UP)
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
		print("fliped")
func Check_for_outfit():
	match current_outfit:
		player:
			Player_outfit.visible=true
			Enemy_outfit.visible=false
			Enemy_outfit2.visible=false
			Enemy_outfit3.visible=false
			print("hii")
