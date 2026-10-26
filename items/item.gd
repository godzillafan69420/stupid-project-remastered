extends Area2D

@export var identifier: item_resource
const made_up_gravity: float = 2.5
var speed = 1



func _process(delta: float) -> void:
	speed += made_up_gravity
	position.y += speed * delta
	if position.y > 700:
		queue_free()


	


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_collection_system"):
		match int(identifier.item):
			identifier.item_types.health:
				PlayerInv.player_HP += 1
				Eventbus.update_ui.emit()
			identifier.item_types.bomb:
				PlayerInv.player_bombs += 1
				Eventbus.update_ui.emit()
			identifier.item_types.power:
				PlayerInv.player_power += 1
				Eventbus.update_ui.emit()
		queue_free()
