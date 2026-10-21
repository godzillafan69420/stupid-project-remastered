extends Area2D

@export var enemy_stats: enemy

func _process(delta: float) -> void:
	position += enemy_stats.speed * Vector2.DOWN * delta
	if position.y > 400:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		queue_free()
	
