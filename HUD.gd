extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var checkpoint_message_displayed = 0
var readied = false
var timePassed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$checkpoint.hide()
	readied = false
	level_name_finder()
	pass # Replace with function body.

func _on_player_colourChanged(col,counto):
	if col ==0:
		$Polygon2D.color = Color(float(1),0,0,1)
		$ammo_count.add_color_override("font_outline_modulate",Color(1,0,0,1))
	elif col == 1:
		$Polygon2D.color = Color(0,float(1),0,1)
		$ammo_count.add_color_override("font_outline_modulate",Color(0,1,0,1))
	elif col == 2:
		$Polygon2D.color = Color(0,0,float(1),1)
		$ammo_count.add_color_override("font_outline_modulate",Color(0,0,1,1))
	$ammo_count.text = str(counto)

func _process(delta):
	if checkpoint_message_displayed >0:
		checkpoint_message_displayed -= delta
	else:
		$checkpoint.hide()
	if readied == false:
		timePassed += delta
		if timePassed >0.05:
			timePassed =0
			$cover.modulate.a = $cover.modulate.a - 0.02
		if $cover.modulate.a <= 0:
			get_node("cover/Level_Name").hide()
			get_node("cover").hide()
			readied = true
			

func _on_checkpoint_activating(pos):
	checkpoint_message_displayed = 2
	$checkpoint.show()

func level_name_finder():
	var texty = get_node("cover/Level_Name")
	var level = get_tree().get_current_scene().filename
	level = level.split("_")

	var nlevel = int(level[1].split(".")[0])

	match nlevel:
		0:
			texty.text = "Tutorial"
		1:
			texty.text = "Level 1: Welcome!"
		2:
			texty.text = "To Be Continued?"
			Global.gameCompleted = true
		3:
			texty.text = "Level 3: Incomplete Level"
		_:
			texty.text = "Mystery!"