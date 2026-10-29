extends Control

func _ready() -> void:
	$Button.grab_focus.call_deferred()
	AudioManager.play("Death")
	


	


func _on_button_2_button_down() -> void:
	PlayerInv.player_bombs = 3
	PlayerInv.player_HP = 10
	get_tree().change_scene_to_file("res://levels/stage_1_act_1.tscn")


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")
