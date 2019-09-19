extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var collect_spawn = load("res://collectible.tscn")
var scene_instance
var active = false
var fading = false
var timePassed=0
signal checkpoint_activating(pos)
var curRed =0
var curGreen =0
var curBlue =0
var pl
var can_absorb = false
# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("Checkpoint")
	$Emit.color = Color(1.0,0.75,1.0,0)
	$textBubble.hide()
	pl = self.owner.get_node("player")
	var checkpoints =get_tree().get_nodes_in_group("Checkpoint")
	for i in checkpoints:
		connect("checkpoint_activating",i,"_on_Checkpoint_checkpoint_activating")
	connect("checkpoint_activating",self.owner.get_node("HUD"),"_on_checkpoint_activating")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timePassed = timePassed + delta
	if active == true:
		$Sprite.playing = true
		check_resource()
		if timePassed < 1:
			$Emit.scale = $Emit.scale + 0.01*Vector2(1,1)
		elif timePassed <2:
			$Emit.scale = $Emit.scale -0.01*Vector2(1,1)
		else:
			timePassed = 0
			$Emit.scale = Vector2(1,1)
		if fading == false:
			if $Emit.color.a<1:
				$Emit.color.a += 0.01
			else:
				fading = true
		else:
			if $Emit.color.a>0:
				$Emit.color.a -= 0.01
			else:
				fading = false
	else:
		$Sprite.playing = false
		timePassed=0
		$Emit.color.a = 0
		$Emit.scale = Vector2(1,1)
	if curRed<=0 && curGreen<=0 && curBlue<=0:
		can_absorb = false
	if can_absorb == true:
		if Input.is_action_just_pressed("interact"):
			can_absorb = false
			var all_orbs_to_be_destroyed = get_tree().get_nodes_in_group("shot_Collectibles")
			for j in  all_orbs_to_be_destroyed:
				j.hide()
				j.free()
			for i in curRed:
				scene_instance = collect_spawn.instance()
				scene_instance.set_name(str("shot_Collectible_red",i))
				scene_instance.owner = self.owner
				add_child(scene_instance)
				
				get_node(str("shot_Collectible_red",i,"/Polygon2D")).color = Color(float(1),0,0,0.5)
				print(get_node(str("shot_Collectible_red",i,"/Polygon2D")).color)
				
				scene_instance.add_to_group("shot_Collectibles")
			for i in curGreen:
				
				scene_instance = collect_spawn.instance()
				scene_instance.set_name(str("shot_Collectible_green",i))
				scene_instance.owner = self.owner
				add_child(scene_instance)
				get_node(str("shot_Collectible_green",i,"/Polygon2D")).color = Color(0,float(1),0,0.5)
				
				scene_instance.add_to_group("shot_Collectibles")
			for i in curBlue:
				
				scene_instance = collect_spawn.instance()
				scene_instance.set_name(str("shot_Collectible_blue",i))
				scene_instance.owner = self.owner
				add_child(scene_instance)
				get_node(str("shot_Collectible_blue",i,"/Polygon2D")).color = Color(0,0,float(1),0.5)
				
				scene_instance.add_to_group("shot_Collectibles")
	else:
		$textBubble.hide()
		if position.distance_to(pl.position) <83:
			if curRed>0 || curGreen>0 || curBlue>0:
				$textBubble.show()
				can_absorb = true

func _on_Checkpoint_body_entered(body):
	if (body.get_name() == "player"):
		if active == false:
			var checkpoints =get_tree().get_nodes_in_group("Checkpoint")
			for i in checkpoints:
				connect("checkpoint_activating",i,"_on_Checkpoint_checkpoint_activating")
			emit_signal("checkpoint_activating",position)
			active = true
		else:
			active = true
		check_resource()
		if curRed>0 || curGreen>0 || curBlue>0:
			$textBubble.show()
			can_absorb = true
		

func check_resource():
	curRed = self.owner.redProgress - pl.colourSCount[0]
	curGreen = self.owner.greenProgress - pl.colourSCount[1]
	curBlue = self.owner.blueProgress - pl.colourSCount[2]

func _on_Checkpoint_checkpoint_activating(pos):
	if pos == position:
		active = true
	else:
		active = false

func _on_player_death():
	check_resource()

func _on_Checkpoint_body_exited(body):
	if (body.get_name() == "player"):
		$textBubble.hide()
		can_absorb = false