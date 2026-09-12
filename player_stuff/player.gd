extends Node2D

#stats

@export var speed:int = 600
@export var slowing_down_speed:int = 200
@export var bomb: PackedScene
@export var bomb_cost:int = 20
@export var shot_type_1:PackedScene
@export var shot_type_2:PackedScene

var current_speed = speed

func _process(delta: float) -> void:
	if Input.is_action_pressed("slow_down"):
		current_speed = slowing_down_speed
	else:
		current_speed = speed
	var directionX = Input.get_axis("left", "right")
	var directionY = Input.get_axis("up", "down")
		
	position += Vector2(directionX, directionY).normalized() * current_speed *delta
		
	
