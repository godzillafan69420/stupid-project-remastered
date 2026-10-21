extends Resource
class_name enemy

@export var speed: int
@export var bullet_pattern:PackedScene

func _init(Vspeed = 100, Vbullet_pattern = null) -> void:
	speed = Vspeed
	bullet_pattern = Vbullet_pattern
