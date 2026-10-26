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

	
	
