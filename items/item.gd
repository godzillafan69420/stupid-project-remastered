extends Area2D

@export var identifier: item_resource
const made_up_gravity: float = 2.5
var speed = 1


func _process(delta: float) -> void:
	speed += made_up_gravity
	position.y += speed * delta


	
