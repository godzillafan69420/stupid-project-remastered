extends Area2D

@export var patterns: Array[boss_attack]
@export var speed: float
@export var hitpoint: float

var current_attack: int = 0
var playable_player

var random_position: Vector2 


func get_next_item(arr: Array, index: int):
	if arr == null or arr.is_empty():
		return null

	var next_index = index + 1
	
	if next_index < arr.size():
		return arr[next_index]
	
	return null

func _ready() -> void:
	$frequency.wait_time = patterns[current_attack].attack_speed
	random_position = global_position
	playable_player = get_parent().get_node("player")
	
	
func _process(delta: float) -> void:
	if get_next_item(patterns, current_attack) != null:
		if hitpoint < get_next_item(patterns, current_attack).hp_level:
			current_attack += 1
			$frequency.wait_time = patterns[current_attack].attack_speed
	global_position = global_position.move_toward(random_position, speed * delta)
	if hitpoint < 0:
		queue_free()
	
func use_attack_pattern(active_pattern):
	if (active_pattern or active_pattern.bullet_scene) and active_pattern.special_patterns:
		var player_pos = playable_player.global_position if playable_player else Vector2.ZERO
		
		# Ask the Resource file to do the math heavy lifting
		var spawns = active_pattern.calculate_bullet_vectors(global_position, player_pos, active_pattern.aimed_at_player)
		
		# Physically spawn the calculated outputs
		for data in spawns:
			var new_bullet = active_pattern.bullet_scene.instantiate()
			new_bullet.global_position = global_position
			new_bullet.direction = data["direction"]
			new_bullet.add_to_group("enemy_bullet")
			
			# Optional: pass down curving properties to your bullet scene
			if "curve" in new_bullet:
				new_bullet.curve = data["curve"]
				
			get_parent().add_child(new_bullet)
			
	else:
		var new_bullet = active_pattern.bullet_scene.instantiate()
		new_bullet.global_position = global_position
		if active_pattern.aimed_at_player:
			new_bullet.direction = playable_player.global_position - global_position
		else:
			new_bullet.direction = Vector2.DOWN
			
		new_bullet.add_to_group("enemy_bullet")
		if "curve" in new_bullet:
				new_bullet.curve = active_pattern.bullet_curve
		get_parent().add_child(new_bullet)


func _on_frequency_timeout() -> void:
	for i in patterns[current_attack].patterns:
		use_attack_pattern(i)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		
		hitpoint -= area.bullet_stats.damage
		if area.bullet_stats.destroy_on_impact:
			
			area.queue_free()


func _on_move_around_frequency_timeout() -> void:
	random_position = Vector2(randf_range(400,750), randf_range(50,200))
