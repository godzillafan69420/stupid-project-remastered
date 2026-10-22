extends Resource
class_name enemy

@export var speed: int
@export var bullet_pattern:PackedScene

@export var Hitpoint:float

func _init(Vspeed = 100, Vbullet_pattern = null, HP = 100) -> void:
	speed = Vspeed
	bullet_pattern = Vbullet_pattern
	Hitpoint = HP
