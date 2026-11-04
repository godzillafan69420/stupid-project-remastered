extends Area2D

@export var bullet_stats: bullet 

var direction: Vector2
var curve: float = 0.0 

var is_target:bool = false
var target:Area2D


func _ready() -> void:
	rotation = Vector2.UP.angle_to(direction)

func _process(delta: float) -> void:
	if !is_target:
		direction = Vector2.UP
	else:
		if target == null:
			is_target = false
			return
		direction = target.position - position
		
	
	global_position += direction.normalized() * bullet_stats.speed * delta
	
	if global_position.y < -10 or global_position.y > 700 or global_position.x < -10 or global_position.x > 967:
		queue_free()
	



func _on_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		is_target = true
		target = area
		


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_bullet") and self.is_in_group("bombs"):
		area.queue_free()
