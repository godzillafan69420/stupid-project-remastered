extends Resource
class_name bullet

@export var speed: float
@export var damage: float 

@export var destroy_on_impact: bool

func _init(new_speed= 100, new_damage = 10, destroy= true) -> void:
	speed = new_speed
	damage = new_damage
	destroy_on_impact = destroy
