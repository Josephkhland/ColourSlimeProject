extends Node

# Declare member variables here. Examples:
var gameCompleted = false
var totalRed = 0
var totalGreen =0
var totalBlue =0

var sprite_on_option = false
var volume_control = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
