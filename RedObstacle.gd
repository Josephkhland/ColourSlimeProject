extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var respawn_time = -1
export var linked_node = "NULL"
var start_respawn = false
var timePassed =0

func _ready():
	$CollisionPolygon2D.polygon= $Polygon2D.polygon
	set_contact_monitor( true )
	set_max_contacts_reported( 5 )


func _on_collectible_breakWall(id):
	print("Success?")
	if id == self.get_name():
		activation(false)
		if respawn_time == -1:
			queue_free()
		elif respawn_time == -2:
			return
		else:
			start_respawn = true

func _process(delta):
	
	if start_respawn == true:
		timePassed += delta
		if timePassed >= respawn_time:
			activation(true)
			timePassed = 0
			start_respawn = false

func activation(nani):
	if nani == true:
		show()
		$CollisionPolygon2D.disabled = false
		set_collision_layer_bit(0,true)
		set_collision_mask_bit(0,true)
		interact_with_linked_node(false)
	else:
		$CollisionPolygon2D.disabled = true
		set_collision_layer_bit(0,false)
		set_collision_mask_bit(0,false)
		hide()
		interact_with_linked_node(true)

# activity == false : Makes the objects disappear
# activity == true : Makes the objects appear.
func interact_with_linked_node(activity):
	var address = self.owner.get_node(linked_node)
	if address != null:
		var sub_objects = address.get_children()
		for i in sub_objects:
			i.get_node("CollisionPolygon2D").disabled = not activity
			i.set_collision_layer_bit(0,activity)
			i.set_collision_mask_bit(0,activity)
			if i.linked_node != get_parent().get_name():
				i.interact_with_linked_node(not activity)
			if activity == true:
				i.show()
			else:
				i.hide()