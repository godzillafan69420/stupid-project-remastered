extends Resource
class_name item_resource

enum item_types {health, bomb, power}


@export var item: item_types
@export var given: int

func _init(what_item = item_types.health, how_much:int = 1) -> void:
	item = what_item
	given = how_much
