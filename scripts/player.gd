extends Node2D

@export var player_stats: player

var current_speed
var shot_interval: Timer
var can_shoot: bool = true

func _ready() -> void:
	current_speed = player_stats.speed
	shot_interval = $"shoot interval"
	

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("slow_down"):
		current_speed = player_stats.slowing_down_speed
	else:
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
		_shoot()
		shot_interval.start(player_stats.shot_time_1)
		

func _shoot():
	var new_bullet = player_stats.shot_type_1.instantiate()
	new_bullet.global_position = global_position
	new_bullet.direction = Vector2.UP
	new_bullet.add_to_group("player_bullet")
	get_parent().add_child(new_bullet)
	can_shoot = false


func _on_shoot_interval_timeout() -> void:
	can_shoot = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_bullet"):
		PlayerInv.player_HP -= 1
