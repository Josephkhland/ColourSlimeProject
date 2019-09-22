extends RichTextLabel

# Declare member variables here. Examples:
var timePassed =0
const REVEAL_TIME = 0.1
var completed = false
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_parent().get_parent().get_node("Button").hide()
	completed = false
	timePassed=0
	visible_characters = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timePassed += delta
	if visible_characters == -1:
		completed = true
		get_parent().get_parent().get_parent().get_node("Button").show()

		if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("ui_select"):
			_on_Button_pressed()
	if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("ui_select"):
		visible_characters = -1
		completed = true
	if timePassed > REVEAL_TIME && completed == false:
		timePassed =0
		visible_characters += 1
	if visible_characters >= 523:
		visible_characters = -1
	

func _on_Button_pressed():
	get_tree().change_scene("res://Levels/Level_1.tscn")
	Global.totalRed = 0
	Global.totalGreen = 0
	Global.totalBlue = 0
