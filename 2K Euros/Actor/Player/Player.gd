extends KinematicBody2D

# we can just call it with or stats
const Move_speed=250



var move_vector
var Velocity=Vector2()
var fliped 


#cast variables
onready var Player_outfit:Node2D= get_node("Body/Player_outfit")
onready var meele:Node2D=get_node("Body/Enemy outfit")
onready var Bow:Node2D=get_node("Body/Enemy outfit2")
onready var other:Node2D=get_node("Body/Enemy outfit3")
onready var Body:Node2D=get_node("Body")

enum{
	player,
	meele_outfit,
	Bow_outfit,
	otherenemies_outfit
}
var current_outfit=player
#stats
var stats={
	"health":100,
	"Move_speed":150,
	"attack_damage":20
}
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
func Check_for_outfit():
	match current_outfit:
		player:
			Player_outfit.visible=true
			meele.visible=false
			Bow.visible=false
			other.visible=false
		meele_outfit:
			Player_outfit.visible=false
			meele.visible=true
			Bow.visible=false
			other.visible=false
		Bow_outfit:
			Player_outfit.visible=false
			meele.visible=false
			Bow.visible=true
			other.visible=false
		otherenemies_outfit:
			Player_outfit.visible=false
			meele.visible=false
			Bow.visible=false
			other.visible=true
func getting_damaged():
	
