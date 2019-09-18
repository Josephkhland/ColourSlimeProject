extends KinematicBody2D

var path = null
var player = null
var prevX = 0
var pathIdx = 0
var speed = 2
var direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	path = get_parent().get_node("Path2D/PathFollow2D")
	player = self.owner.get_node("player")
	
	$CollisionPolygon2D.polygon = $Polygon2D.polygon
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not path == null:
		path.set_offset(pathIdx)
		position = path.position
		if direction == 0:
			pathIdx += speed
		else:
			pathIdx -= speed
		if path.offset >1650:
			direction = 1
		elif path.offset <50:
			direction = 0
		pass

