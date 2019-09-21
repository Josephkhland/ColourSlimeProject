extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var optionMenu
# Called when the node enters the scene tree for the first time.
func _ready():
	optionMenu = owner.get_node("Options_menu")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Options_toggled(button_pressed):
	optionMenu.open = button_pressed
