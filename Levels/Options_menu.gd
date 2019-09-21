extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	get_node("VBoxContainer/HSplitContainer/player_sprite_on").pressed = Global.sprite_on_option
	get_node("VBoxContainer/HBoxContainer/Sound_Volume").value = db2linear(Global.volume_control)
	get_node("VBoxContainer/HBoxContainer/Sound_Volume").min_value = 0.0001
	get_node("VBoxContainer/HBoxContainer/Sound_Volume").step = 0.0001
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if open == true:
		show()
	else:
		hide()


	


func _on_player_sprite_on_toggled(button_pressed):
	Global.sprite_on_option = button_pressed


func _on_Sound_Volume_value_changed(value):
	Global.volume_control = linear2db(value)
	print (db2linear(Global.volume_control))
