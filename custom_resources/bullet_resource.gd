extends Resource
class_name bullet

@export var speed: float
@export var damage: float 

func _init(new_speed= 100, new_damage = 10) -> void:
	speed = new_speed
	damage = new_damage
