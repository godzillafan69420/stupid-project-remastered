extends Control

@onready var health = $TextureRect/Health
@onready var bomb = $TextureRect/bomb
@onready var power = $"TextureRect/power"
@onready var money = $TextureRect/Health

const icon = preload("res://art/health_bar.png")

func _ready() -> void:
	_change_ui()
	Eventbus.update_ui.connect(_change_ui)
	
	
func _change_ui()-> void:
	for child in health.get_children():
		child.queue_free()
	for child in bomb.get_children():
		child.queue_free()
	for i in range(PlayerInv.player_HP-1):
		var new_display = TextureRect.new()
		new_display.texture = icon
		health.add_child(new_display)
	for i in range(PlayerInv.player_bombs-1):
		var new_display = TextureRect.new()
		new_display.texture = icon
		bomb.add_child(new_display)
	power.text = str(PlayerInv.player_power)+ "/100"
