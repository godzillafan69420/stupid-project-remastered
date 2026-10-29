extends Control


func _ready() -> void:
	$Button.grab_focus.call_deferred()
	AudioManager.play("TItleScreen")

func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")
