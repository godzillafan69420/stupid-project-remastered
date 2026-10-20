extends Node

var parent_node

func _ready() -> void:
	parent_node = get_parent()


func _process(delta: float) -> void:
	if Input.is_action_pressed("slow_down"):
		parent_node.current_speed = parent_node.slowing_down_speed
	else:
		parent_node.current_speed = parent_node.speed
	var directionX = Input.get_axis("left", "right")
	var directionY = Input.get_axis("up", "down")
		
	parent_node.position += Vector2(parent_node.directionX, parent_node.directionY).normalized() * parent_node.current_speed *delta
		
