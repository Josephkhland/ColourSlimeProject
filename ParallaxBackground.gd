extends ParallaxBackground

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timePassed

# Called when the node enters the scene tree for the first time.
func _ready():
	timePassed =0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timePassed += delta
	if timePassed >= 0.1:
		$ParallaxLayer2.rotation -=0.01
		$ParallaxLayer.rotation +=0.01
		#get_node("ParallaxLayer2/Polygon2D").rotation -=0.01
		timePassed =0

