extends Resource
class_name item_resource

var item_types: Array[String] = ["soul", "bomb", "power"]
@export var item: int
@export var given: int

func _init(what_item:int = 0, how_much:int = 1) -> void:
	item = what_item
	given = how_much
