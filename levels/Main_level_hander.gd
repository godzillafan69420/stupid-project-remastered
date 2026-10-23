extends Node2D

@export var enemy_pool: Array[PackedScene]
@export var enemy_spawn_interval: float

@onready var boss_timer: Timer = $Boss_timer

@export var boss_scene:PackedScene

var enemy_spawner_timer: Timer

func _ready() -> void:
	enemy_spawner_timer = $enemy_spawn_interval
	enemy_spawner_timer.wait_time = enemy_spawn_interval
	
	
func _spawn_enemies_on_random():
	var new_enemy = enemy_pool[0].instantiate()
	new_enemy.position.x = randf_range(0,  950)
	new_enemy.position.y = -50
	new_enemy.add_to_group("enemies")
	add_child(new_enemy)
	


func _on_enemy_spawn_interval_timeout() -> void:
	_spawn_enemies_on_random()


func _on_boss_timer_timeout() -> void:
	pass # Replace with function body.
