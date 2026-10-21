extends Node2D

@export var pattern_resource: patterns
var rounds = 0
var per_timer: Timer 
var length_timer: Timer


func _ready() -> void:
	per_timer = $per_times
	per_timer.wait_time = pattern_resource.how_many_times
	length_timer = $length
	
	
	
	


func _on_length_timeout() -> void:
	queue_free()
