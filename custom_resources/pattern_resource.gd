# --- BulletPattern.gd ---
class_name BulletPattern
extends Resource

enum PatternType { RING, SPIRAL, PINWHEEL, STRAIGHT}

@export var name: String = "Default Pattern"
@export var type: PatternType = PatternType.RING
@export var bullet_scene: PackedScene

@export_group("Movement Settings")
@export var bullet_speed: float = 200.0
@export var bullet_curve: float = 0.0 

@export_group("Pattern Controls")
@export var count: int = 12            
@export var spin_rate: float = 0.05     


var current_angle: float = 0.0


func calculate_bullet_vectors(origin: Vector2, player_pos: Vector2 = Vector2.ZERO, is_aimed: bool = false) -> Array[Dictionary]:
	var bullet_data: Array[Dictionary] = []

	var base_angle = 0.0
	if is_aimed and player_pos != Vector2.ZERO:
		base_angle = origin.angle_to_point(player_pos)

	match type:
		PatternType.RING:
			var angle_step = (2 * PI) / max(1, count)
			for i in range(count):
				var angle = base_angle + (i * angle_step)
				var dir = Vector2(cos(angle), sin(angle))
				bullet_data.append({"direction": dir, "speed": bullet_speed, "curve": bullet_curve})

		PatternType.SPIRAL:
			current_angle += spin_rate
			var angle = base_angle + current_angle
			var dir = Vector2(cos(angle), sin(angle))
			bullet_data.append({"direction": dir, "speed": bullet_speed, "curve": bullet_curve})

		PatternType.PINWHEEL:
			current_angle += spin_rate
			var angle_step = (2 * PI) / max(1, count)
			for i in range(count):
				var angle = base_angle + (i * angle_step) + current_angle
				var dir = Vector2(cos(angle), sin(angle))
				bullet_data.append({"direction": dir, "speed": bullet_speed, "curve": bullet_curve})
		PatternType.STRAIGHT:
			var angle = base_angle + PI/2
			var dir = Vector2(cos(angle), sin(angle))
			bullet_data.append({"direction": dir, "speed": bullet_speed, "curve": bullet_curve})
	return bullet_data
