extends Area2D


@export var speed = 100
@export var damage: float = 10

var direction: Vector2
func _process(delta: float) -> void:
	position += direction.normalized() * speed * delta
	if position.y < -10:
		queue_free()
		
