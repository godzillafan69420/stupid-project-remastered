extends Area2D


@export var bullet_stats: bullet 

var direction: Vector2
var curve: float = 0.0 

func _ready() -> void:

	rotation = Vector2.UP.angle_to(direction)

func _process(delta: float) -> void:
	if curve != 0.0:
		direction = direction.rotated(curve * delta)
		rotation = Vector2.UP.angle_to(direction)
	
	global_position += direction.normalized() * bullet_stats.speed * delta
	
	if global_position.y < -10 or global_position.y > 700 or global_position.x < -10 or global_position.x > 967:
		queue_free()
	
	
		
