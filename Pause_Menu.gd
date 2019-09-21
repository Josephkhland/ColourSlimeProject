extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Continue_pressed():
	get_tree().paused = false
	get_node("VBoxContainer/Options").pressed = false
	self.hide()


func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_Quit_to_Menu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Levels/Menu.tscn")
	pass # Replace with function body.


