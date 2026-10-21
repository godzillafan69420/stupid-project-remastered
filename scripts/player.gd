extends Node2D


@export var speed:int = 600
@export var slowing_down_speed:int = 200
@export var bomb: PackedScene
@export var bomb_cost:int = 20
@export var shot_type_1:PackedScene
@export var shot_time_1: float
@export var shot_type_2:PackedScene
@export var shot_time_2: float

var current_speed = speed
var shot_interval: Timer
var can_shoot: bool = true

func _ready() -> void:
	shot_interval = $"shoot interval"
	

func _process(delta: float) -> void:
	if Input.is_action_pressed("slow_down"):
		current_speed = slowing_down_speed
	else:
		current_speed = speed
	var directionX = Input.get_axis("left", "right")
	var directionY = Input.get_axis("up", "down")
		
	position += Vector2(directionX, directionY).normalized() * current_speed *delta
	if Input.is_action_pressed("shoot") and can_shoot:
		_shoot()
		shot_interval.start(shot_time_1)
		

func _shoot():
	var new_bullet = shot_type_1.instantiate()
	new_bullet.global_position = global_position
	new_bullet.direction = Vector2.UP
	new_bullet.add_to_group("player_bullet")
	get_parent().add_child(new_bullet)
	can_shoot = false


func _on_shoot_interval_timeout() -> void:
	can_shoot = true
