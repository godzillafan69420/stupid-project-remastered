extends Area2D

@export var enemy_stats: enemy
var enemy_HP: float

func _ready() -> void:
	enemy_HP = enemy_stats.Hitpoint

func _process(delta: float) -> void:
	
	position += enemy_stats.speed * Vector2.DOWN * delta
	if position.y > 700:
		queue_free()
	if enemy_HP <= 0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		enemy_HP -= area.bullet_stats.damage
		if area.bullet_stats.destroy_on_impact:
			area.queue_free()
		
	
