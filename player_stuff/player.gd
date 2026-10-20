extends Resource
class_name player

#stats

@export var speed:int = 600
@export var slowing_down_speed:int = 200
@export var bomb: PackedScene
@export var bomb_cost:int = 20
@export var shot_type_1:PackedScene
@export var shot_type_2:PackedScene

var current_speed = speed


func _shoot():
	var bullet = shot_type_1.instatiate()
