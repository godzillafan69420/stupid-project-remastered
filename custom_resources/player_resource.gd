extends Resource
class_name player

@export var speed:int 
@export var slowing_down_speed:int 
@export var bomb: PackedScene
@export var bomb_cost:int 

@export var upgrades: Array[weapon_level_data] = []

func get_current_weapon() -> weapon_level_data:
	var idx = clamp(PlayerInv.player_power - 1, 0, upgrades.size() - 1)
	return upgrades[idx]

func _init(vspeed= 600, slowing = 200, vbomb = null, vbomb_cost = 20, shot1 = null, cooldown1 = 0.1, shot2 = null, cooldown2 = 0.1) -> void:
	speed = vspeed
	slowing_down_speed = slowing
	bomb = vbomb
	bomb_cost = vbomb_cost
	
	
