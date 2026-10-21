extends Resource
class_name patterns

@export var name: String = "defalt"
@export var max_time: float = 60
@export var how_much_per_patterns_per: int = 10

@export var damage_required: float = 1000


func _init(spell_name, time, interval, damage) -> void:
	name = spell_name
	max_time = time
	how_much_per_patterns_per = interval
	damage_required = damage
