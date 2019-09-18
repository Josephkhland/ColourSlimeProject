extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionPolygon2D.polygon= $Polygon2D.polygon
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_WalkThroughWall_body_entered(body):
	if body.get_name() == "player":
		if body.my_color.b >0:
			$CollisionPolygon2D.disabled = true
	pass # Replace with function body.
