extends Area2D

@export var speed = 100
@export var bullet_pattern:PackedScene

func _process(delta: float) -> void:
	position += speed * Vector2.DOWN * delta
	if position.y > 400:
		queue_free()
