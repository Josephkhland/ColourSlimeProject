extends Node2D

var collect_spawn = load("res://collectible.tscn")
var scene_instance
var counter
var bullet_power
var redProgress
var blueProgress
var greenProgress
var loaded = false

signal orb_fired(col)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	redProgress =0
	blueProgress =0
	greenProgress =0
	counter =0
	bullet_power=200
	connect("orb_fired",get_node("collectible"),"_on_Node2D_orb_fired")
	loaded = false
	


func _on_player_shoot_orb(dir,col):
	counter= counter+1
	scene_instance = collect_spawn.instance()
	scene_instance.set_position($player.position + 15*$player.scale*dir)
	scene_instance.set_name(str("shot_Collectible",counter))
	add_child(scene_instance)
	scene_instance.apply_central_impulse(dir*bullet_power)
	scene_instance.add_to_group("shot_Collectibles")
	if col == 0:
		get_node(str("shot_Collectible",counter,"/Polygon2D")).color = Color(float(1),0,0,0.25)
	elif col == 1:
		get_node(str("shot_Collectible",counter,"/Polygon2D")).color = Color(0,float(1),0,0.25)
	else:
		get_node(str("shot_Collectible",counter,"/Polygon2D")).color = Color(0,0,float(1),0.25)

func _on_orb_collected(col,orbName):
	print("God- Dammit!")
	if "shot" in orbName:
		return
	else:
		if col.r>0:
			redProgress +=1
		if col.g>0:
			greenProgress +=1
		if col.b>0:
			blueProgress +=1

