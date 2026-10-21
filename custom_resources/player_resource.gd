extends Resource
class_name player

@export var speed:int 
@export var slowing_down_speed:int 
@export var bomb: PackedScene
@export var bomb_cost:int 
@export var shot_type_1:PackedScene
@export var shot_time_1: float
@export var shot_type_2:PackedScene
@export var shot_time_2: float

func _init(vspeed= 600, slowing = 200, vbomb = null, vbomb_cost = 20, shot1 = null, cooldown1 = 0.1, shot2 = null, cooldown2 = 0.1) -> void:
	speed = vspeed
	slowing_down_speed = slowing
	bomb = vbomb
	bomb_cost = vbomb_cost
	shot_type_1 = shot1
	shot_time_1 = cooldown1
	shot_type_2 = shot2
	shot_time_2 = cooldown2
