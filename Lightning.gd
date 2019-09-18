extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timePassed

# Called when the node enters the scene tree for the first time.
func _ready():
	timePassed=0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timePassed += delta
	if timePassed > 0.5:
		scale.y = -scale.y
		print("FLIP!")
		timePassed = 0


func _on_Lightning_body_entered(body):
	if body.get_name() == "player":
		body.damaged()
	elif "shot" in body.get_name():
		body.queue_free()
	pass # Replace with function body.
