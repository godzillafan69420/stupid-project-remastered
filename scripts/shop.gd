extends Control

func _ready() -> void:
	$HBoxContainer/bombs.grab_focus.call_deferred()
	_update_ui()
	

func _update_ui():
	$Bomb_label.text = "Bombs: " + str(PlayerInv.player_bombs)
	$Power_label.text = "Power: " +str(PlayerInv.player_power)
	$Health_label.text = "Health: " +str(PlayerInv.player_HP)
	$Gold_label.text = "Gold: " +str(PlayerInv.player_gold)
func _on_bombs_button_down() -> void:
	if PlayerInv.player_gold >= 25 and PlayerInv.player_bombs <= 10:
		PlayerInv.player_gold -= 25
		PlayerInv.player_bombs += 1
		_update_ui()


func _on_power_button_down() -> void:
	if PlayerInv.player_gold >= 10 :
		PlayerInv.player_gold -= 10
		PlayerInv.player_power += 15
	if PlayerInv.player_power > 100:
		PlayerInv.player_power = 100
	_update_ui()


func _on_health_button_down() -> void:
	if PlayerInv.player_gold >= 50 and PlayerInv.player_HP <= 10:
		PlayerInv.player_gold -= 50
		PlayerInv.player_HP += 1
		_update_ui()


func _on_next_button_down() -> void:
	pass # Replace with function body.
