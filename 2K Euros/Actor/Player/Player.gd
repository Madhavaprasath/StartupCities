extends KinematicBody2D
class_name Player
# we can just call it with or stats

onready var fireball_scn = preload("res://Actor/Fireball/Fireball.tscn")

var move_vector
var Velocity=Vector2()
var current_animation = ""
var attacking = false
var groupname="Mage"
var previous_group_name=null
onready var character_sprite = $Body/CharacterSprite
onready var weapon_position = $Body/Hold_position
onready var fireball_spawn_point = $Body/Hold_position/Sprite/FireballSpawnPoint
onready var camera_handler = $CameraHandler
onready var camera = $Camera2D


#stats
var stats={
	"health":100,
	"Move_speed":250,
	"attack_damage":20
}

var player_interactables = []

onready var animation_player:AnimationPlayer=get_node("Body/CharacterSprite/AnimationPlayer")


func _ready():
	current_animation = "Idle"
	animation_player.play(groupname + "_" + current_animation)


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
	
	return Vector2(x, y)


func flip_character(movement):
	if movement.x != 0:
		character_sprite.scale.x = movement.x


func camera_snap():
	for area in camera_handler.get_overlapping_areas():
		if area.is_in_group("CAMERA_SNAP"):
			camera.limit_left = area.position.x
			camera.limit_right = area.position.x + 512 * area.scale.x
			camera.limit_top = area.position.y
			camera.limit_bottom = area.position.y + 320 * area.scale.y


func getting_damaged(area):
	stats["health"]-=area.stats["damage"]
	if stats["health"]<=0:
		previous_group_name=groupname
		groupname=area.groupname
		stats["health"]=100


func _on_Player_hurtBox_area_entered(area):
	getting_damaged(area)


func rotate_aim():	
	weapon_position.rotate(weapon_position.get_angle_to(get_global_mouse_position()))


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ["Cat_Attack", "Ogre_Attack", "Mage_Attack"]:
		animation_player.play(groupname + "_" + current_animation)


func shoot():
	var fireball = fireball_scn.instance()
	fireball.start(fireball_spawn_point.global_position, weapon_position.rotation, true)
	get_tree().root.add_child(fireball)
