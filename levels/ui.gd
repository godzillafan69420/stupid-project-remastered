extends Control

@onready var health = $TextureRect/Health
@onready var bomb = $TextureRect/bomb
@onready var power = $"TextureRect/power"
@onready var boss_timer_dis = $TextureRect/boss_timer_display
@onready var money = $TextureRect/Health

var boss_timer:Timer

const icon = preload("res://art/health_bar.png")

func _ready() -> void:
	boss_timer=get_parent().get_node_or_null("Boss_timer")
	_change_ui()
	Eventbus.update_ui.connect(_change_ui)
	

func _process(delta: float) -> void:
	boss_timer_dis.text = str(int(boss_timer.time_left))
	
func _change_ui()-> void:
	if PlayerInv.player_HP > 10:
		PlayerInv.player_HP = 10
	if PlayerInv.player_bombs > 10:
		PlayerInv.player_bombs = 10
	if PlayerInv.player_power > 100:
		PlayerInv.player_power = 100
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
	
