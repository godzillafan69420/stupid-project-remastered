extends Area2D

@export var bullet_stats: bullet 


var direction: Vector2
func _process(delta: float) -> void:
	position += direction.normalized() * bullet_stats.speed * delta
	if position.y < -10 or position.y >  700 or position.x < -10 or position.x >  1300:
		queue_free()
	
	
		
