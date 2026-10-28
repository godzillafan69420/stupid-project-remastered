extends Control

@onready var health = $TextureRect/Health
@onready var bomb = $TextureRect/bomb
@onready var power = $"TextureRect/power"
@onready var boss_timer_dis = $TextureRect/boss_timer_display
@onready var money = $TextureRect/Health
@onready var dialogue_interface = $dialogue_interface

@onready var boss_bar = $boss_hp

@export var current_dialogue: Array[dialogue]
var boss_node: Area2D
var boss_timer:Timer

var doing_dialogue:bool = false

var dialogue_number: int = 0

const icon = preload("res://art/health_bar.png")

var text_animation  

func _ready() -> void:
	
	boss_timer=get_parent().get_node_or_null("Boss_timer")
	_change_ui()
	Eventbus.update_ui.connect(_change_ui)
	Eventbus.do_dialogue.connect(_show_boss_ui)
	

func _process(delta: float) -> void:
	boss_timer_dis.text = str(int(boss_timer.time_left))
	$TextureRect/FPS.text = str(Engine.get_frames_per_second())
	if get_parent().current_state == get_parent().states.boss:
		boss_bar.value = boss_node.hitpoint


func _unhandled_input(event: InputEvent) -> void:
	if doing_dialogue and event.is_action_pressed("shoot"):
		get_viewport().set_input_as_handled() 
		
		dialogue_number += 1
		if dialogue_number >= current_dialogue.size():
			doing_dialogue = false
			dialogue_interface.visible = false 
			Eventbus.start_the_boss_fight.emit()
		else:
			_next_dialogue(current_dialogue[dialogue_number])

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
	

	
	
func _show_boss_ui() -> void:
	boss_node = get_parent().get_node_or_null("boss")
	boss_bar.visible = true
	boss_bar.max_value = boss_node.hitpoint
	boss_bar.value = boss_node.hitpoint
	dialogue_interface.visible = true
	doing_dialogue = true
	_next_dialogue(current_dialogue[dialogue_number])
	


	

func _next_dialogue(dialogue_data: dialogue):
	AudioManager.play(dialogue_data.music_name)
	var diaglogue_protrait = dialogue_interface.get_node_or_null("Protraits")
	var diaglogue_name = dialogue_interface.get_node_or_null("name")
	var diaglogue_paragraph = dialogue_interface.get_node_or_null("paragraph")
	diaglogue_paragraph.text = dialogue_data.paragraph
	diaglogue_name.text = dialogue_data.reader_name
	diaglogue_protrait.texture = dialogue_data.portraits
	diaglogue_paragraph.visible_ratio = 0
	
	diaglogue_paragraph.visible_ratio = 0.0
	
	text_animation = dialogue_interface.create_tween()
	# Calculate total duration: total characters divided by speed (chars per second)
	var duration = float(diaglogue_paragraph.text.length()) / float(dialogue_data.talk_speed)
	
	text_animation.tween_property(diaglogue_paragraph, "visible_ratio", 1.0, duration)
	text_animation.play()
			
		
