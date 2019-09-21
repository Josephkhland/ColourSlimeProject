extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Start_pressed():
	get_tree().change_scene("res://Levels/Level_0.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Credits_pressed():
	get_tree().change_scene("res://Levels/Credits.tscn")


func _on_Options_toggled(button_pressed):
	$Options_menu.open = button_pressed
