extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal respawn
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("respawn",get_parent(),"respawn")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	emit_signal("respawn")
	get_tree().paused = false
	self.queue_free()
	pass # Replace with function body.
