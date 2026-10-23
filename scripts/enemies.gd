extends Area2D

@export var enemy_stats: enemy
@export var drops: Array[item_resource]
@export var active_pattern: BulletPattern

@export var aimed_at_player: bool = false
var enemy_HP: float
var playable_player

@export var curve: float = 0.0

@export var patterns: bool = false

func _ready() -> void:
	enemy_HP = enemy_stats.Hitpoint
	playable_player = get_parent().get_node_or_null("player")

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
		
	


func _on_shoot_interval_timeout() -> void:
	if (active_pattern or  active_pattern.bullet_scene) and patterns:
		
		
		var player_pos = playable_player.global_position if playable_player else Vector2.ZERO
		
		# Ask the Resource file to do the math heavy lifting
		var spawns = active_pattern.calculate_bullet_vectors(global_position, player_pos, aimed_at_player)
		
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
		if aimed_at_player:
			new_bullet.direction = playable_player.position - position
		else:
			new_bullet.direction = Vector2.DOWN
			
		new_bullet.add_to_group("enemy_bullet")
		if "curve" in new_bullet:
				new_bullet.curve = curve
		get_parent().add_child(new_bullet)
