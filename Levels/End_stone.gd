extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var stone_label = "TEXT"
export var to_do_on_interact = "NULL"
var can_use = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionPolygon2D.polygon = $Polygon2D.polygon
	$Message.hide()
	get_node("Message/MarginContainer/Label").text= stone_label

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if can_use == true:
		if Input.is_action_just_pressed("interact"):
			if to_do_on_interact == "NULL":
				return
			elif to_do_on_interact == "Level_0":
				get_tree().change_scene("res://Levels/Level_0.tscn")
			elif to_do_on_interact == "Level_1":
				get_tree().change_scene("res://Levels/Level_1.tscn")
			elif to_do_on_interact == "Credits":
				get_tree().change_scene("res://Levels/Credits.tscn")

func _on_End_stone_body_entered(body):
	if body.get_name() == "player":
		$Message.show()
		can_use = true


func _on_End_stone_body_exited(body):
	if body.get_name() == "player":
		$Message.hide()
		can_use = false
