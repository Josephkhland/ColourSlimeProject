extends RigidBody2D


var orb_color
# Called when the node enters the scene tree for the first time.
signal orb_taken(c,orbName)
signal breakWall(id)

func _on_collectible_body_entered( body ):
	orb_color = $Polygon2D.color
	if (body.get_name() == "player"):
		if body.polygon.color.r > float(1):
			if orb_color.r >0:
				return
		if body.polygon.color.g > float(1):
			if orb_color.g >0:
				return
		if body.polygon.color.b > float(1):
			if orb_color.b >0:
				return
		$CollisionShape2D.disabled = true
		body.on_orb_taken(orb_color,self.get_name())
		hide()
		emit_signal("orb_taken",orb_color,self.get_name())
		queue_free()
	elif (body.is_in_group("RedObstacle")):
		if orb_color.r>0:
			emit_signal("breakWall",body.get_name())
	elif (body.is_in_group("GreenObstacle")):
		if orb_color.g>0:
			emit_signal("breakWall",body.get_name())
	elif (body.is_in_group("BlueObstacle")):
		if orb_color.b>0:
			emit_signal("breakWall",body.get_name())

func _ready():
	set_contact_monitor( true )
	set_max_contacts_reported( 5 )
	connect("orb_taken",self.owner,"_on_orb_collected")
	$Polygon2D.color = Color(float(randi()%2),float(randi()%2),float(randi()%2),0.5)
	orb_color = $Polygon2D.color
	var red_obstacles =get_tree().get_nodes_in_group("RedObstacle")
	var green_obstacles = get_tree().get_nodes_in_group("GreenObstacle")
	var blue_obstacles = get_tree().get_nodes_in_group("BlueObstacle")
	for i in red_obstacles:
		self.connect("breakWall",i,"_on_collectible_breakWall")
	for i in green_obstacles:
		self.connect("breakWall",i,"_on_collectible_breakWall")
	for i in blue_obstacles:
		self.connect("breakWall",i,"_on_collectible_breakWall")


func _on_Node2D_orb_fired(col):
	
	if col == 0:
		$Polygon2D.color = Color(float(1),0,0,0.25)
	elif col == 1:
		$Polygon2D.color = Color(0,float(1),0,0.25)
	else:
		$Polygon2D.color = Color(0,0,float(1),0.25)
	orb_color= $Polygon2D.color


