extends Node2D
class_name playable_player

@export var player_stats: player

var current_speed
var shot_interval: Timer
var can_shoot: bool = true

const BULLET_SPAWN_OFFSET: Vector2 = Vector2(0,-44)
var weapon: weapon_level_data 

func _ready() -> void:
	weapon= player_stats.upgrades[0]
	current_speed = player_stats.speed
	shot_interval = $"shoot interval"
	

func _process(delta: float) -> void:
	if Input.is_action_pressed("slow_down"):
		current_speed = player_stats.slowing_down_speed
		$hit_box_viewer.visible = true
		
	else:
		$hit_box_viewer.visible = false
		current_speed = player_stats.speed
	var directionX = Input.get_axis("left", "right")
	if directionX ==1 and position.x > 950:
		position.x = 950
	elif directionX == -1 and position.x < 0:
		position.x = 0
	var directionY = Input.get_axis("up", "down")
	if directionY ==1 and position.y > 640:
		position.y = 640
	elif directionY == -1 and position.y < 0:
		position.y = 0
	position += Vector2(directionX, directionY).normalized() * current_speed *delta
	if Input.is_action_pressed("shoot") and can_shoot:
		
		if PlayerInv.player_power <= 10:
			weapon = player_stats.upgrades[0]
			_shoot(weapon)
			shot_interval.start(weapon.shot_cooldown)
		elif PlayerInv.player_power <= 40:
			weapon = player_stats.upgrades[1]
			_shoot(weapon)
			shot_interval.start(weapon.shot_cooldown)
		elif PlayerInv.player_power <= 75:
			weapon = player_stats.upgrades[2]
			_shoot(weapon)
			shot_interval.start(weapon.shot_cooldown)
		elif PlayerInv.player_power <= 100:
			weapon = player_stats.upgrades[3]
			_shoot(weapon)
			shot_interval.start(weapon.shot_cooldown)

func _shoot(weapon: weapon_level_data) -> void:
	if weapon.type == weapon.weapon_type.foward:
		var starting_position = global_position-Vector2(((weapon.bullet_count-1)*weapon.forward_spread)/2, 0)
		for i in range(weapon.bullet_count):
			var new_bullet = weapon.bullet_scene.instantiate()
			new_bullet.global_position = starting_position + Vector2(i *weapon.forward_spread, -64)
			new_bullet.direction = Vector2.UP
			new_bullet.add_to_group("player_bullet")
			get_parent().add_child(new_bullet)
	if weapon.type == weapon.weapon_type.spread:
		var starting_rotation = ((weapon.bullet_count-1) * weapon.spread_angle)/2
		for i in range(weapon.bullet_count):
			
			var new_bullet = weapon.bullet_scene.instantiate()
			new_bullet.global_position = global_position + BULLET_SPAWN_OFFSET
			
			var angle = -starting_rotation+(i*weapon.spread_angle)
			new_bullet.direction = Vector2.UP.rotated(deg_to_rad(angle))
			
			
			new_bullet.add_to_group("player_bullet")
			get_parent().add_child(new_bullet)
	if weapon.type == weapon.weapon_type.full_aoe:
		var angle = 360/weapon.bullet_count
		for i in range(weapon.bullet_count):
			var new_bullet = weapon.bullet_scene.instantiate()
			new_bullet.global_position = global_position +BULLET_SPAWN_OFFSET
			
			
			new_bullet.direction = Vector2.UP.rotated((deg_to_rad(angle*i)))
			
			
			new_bullet.add_to_group("player_bullet")
			get_parent().add_child(new_bullet)
	can_shoot = false
	


func _on_shoot_interval_timeout() -> void:
	can_shoot = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_bullet"):
		PlayerInv.player_HP -= 1
		position = Vector2(570,570)
		Eventbus.update_ui.emit()
