extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enabled = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionPolygon2D.polygon= $Polygon2D.polygon
	$TextBubble.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") && enabled==true:
		
		var level = get_tree().get_current_scene().filename

		level = level.split("_")
		var nLevel = int(level[1].split(".")[0]) +1
		if nLevel == 1:
			get_tree().change_scene("res://Levels/Cutscene.tscn")
		else :
			get_tree().change_scene(str("res://Levels/Level_",nLevel,".tscn"))
			var findPlayer = get_parent().get_node("player")
			if findPlayer != null:
				Global.totalRed += findPlayer.colourSCount[0]
				Global.totalGreen += findPlayer.colourSCount[1]
				Global.totalBlue += findPlayer.colourSCount[2]


func _on_Doorway_body_entered(body):
	if (body.get_name() == "player"):
		enabled=true
		$TextBubble.show()


func _on_Doorway_body_exited(body):
	if (body.get_name() == "player"):
		enabled=false
		$TextBubble.hide()
