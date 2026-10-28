extends Node2D

@export var theme: String
@export var boss_theme: String

@export var enemy_pool: Array[PackedScene]
@export var enemy_spawn_interval: float

@onready var boss_timer: Timer = $Boss_timer

@export var boss_scene:PackedScene

enum states{preboss, dialogue, boss, postboss}

var current_state:states

var enemy_spawner_timer: Timer

func _ready() -> void:
	current_state = states.preboss
	AudioManager.play(theme)
	enemy_spawner_timer = $enemy_spawn_interval
	enemy_spawner_timer.wait_time = enemy_spawn_interval
	
	
func _spawn_enemies_on_random():
	if current_state != states.preboss: return
	var new_enemy = enemy_pool[0].instantiate()
	new_enemy.position.x = randf_range(0,  950)
	new_enemy.position.y = -50
	new_enemy.add_to_group("enemies")
	add_child(new_enemy)
	


func _on_enemy_spawn_interval_timeout() -> void:
	_spawn_enemies_on_random()


func _on_boss_timer_timeout() -> void:
	current_state = states.boss
	AudioManager.play(boss_theme)
	var new_boss = boss_scene.instantiate()
	new_boss.position = Vector2(500,100)
	new_boss.name = "boss"
	add_child(new_boss)
	Eventbus.boss_spawned.emit()
