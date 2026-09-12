extends Node

@onready var main_script = $".."

func _shoot():
	var bullet = main_script.shot_type_1.instatiate()
