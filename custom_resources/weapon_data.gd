extends Resource
class_name weapon_level_data

@export_group("Visual")
@export var bullet_scene: PackedScene


@export_group("actual stuff")
@export var shot_cooldown: float = 0.2
@export var bullet_count: int = 1
enum weapon_type {foward, spread, full_aoe}
@export var type = weapon_type.foward
@export var spread_angle: float = 0.0 

@export var forward_spread: float = 10
