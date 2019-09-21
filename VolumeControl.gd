extends AudioStreamPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if (self.get_name() == "RaveMusic"):
		var level = get_tree().get_current_scene().filename
		print(level)
		if level == "res://Levels/Menu.tscn":
			autoplay = false
			playing = false
		else :
			autoplay = true
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	volume_db = Global.volume_control
	if (self.get_name() == "RaveMusic"):
		var level = get_tree().get_current_scene().filename
		print(level)
		if level == "res://Levels/Menu.tscn":
			autoplay = false
			playing = false
		else :
			autoplay = true
			if playing == false:
				playing = true
			
