extends "res://Actor/Enemies/Enemy.gd"


var bullet_scene=preload("res://Actor/Fireball/Fireball.tscn")

func _physics_process(delta):
	match state:
		Idle:
			velocity=velocity.move_toward(Vector2.ZERO,accerlation*delta)
			check_attack_player()
			check_chase_player()
			if wanderable==true:
				if Wander_controller.check_for_timer()==0:
					state=shuffle_array([Idle,wander])
					Wander_controller.set_duration(rand_range(1,3))
		wander:
			if wanderable==true:
				check_attack_player()
				check_chase_player()
				if Wander_controller.check_for_timer()==0:
					state=shuffle_array([Idle,wander])
					Wander_controller.set_duration(rand_range(1,3))


				var direction=global_position.direction_to(Wander_controller.target_position)
				velocity=velocity.move_toward(direction*stats["Speed"],accerlation*delta)
			
				if global_position.distance_to(Wander_controller.target_position)<=4:
					state=shuffle_array([Idle,wander])
					Wander_controller.set_duration(rand_range(1,3))

		Chase:
				check_attack_player()
				var player=player_detect_zone.player
				if player!=null:
					var direction=(global_position.direction_to(player.global_position)).normalized()
					velocity=velocity.move_toward(direction*stats["Speed"],accerlation*delta)
				else:
					state=shuffle_array([Idle,wander])
		attack:
			var player=Attack_Zone.player
	._physics_process(delta)
func _ready():
	randomize()
