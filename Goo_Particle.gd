extends KinematicBody2D

const GRAVITY = 500.0
const WALK_SPEED = 200
const jumpSpeed = 300
const BLUE_BONUS_TO_JUMP = 20
const GREEN_BONUS_TO_SPEED = 30
var shotBoostSpeed = 200
var jumped = false
var onWall = false
var concec_jumps=0
var my_color 
var orbs_consumed
var colourSelection #0 For Red, 1 For Green, 2 For Blue
var colourSCount
var colourChunk = 0.25
var velocity = Vector2()
var not_stunned = 1
var timeStunned =0
onready var polygon = $Polygon2D


signal orb_was_taken
signal shoot_orb(dir,col)
signal colourChanged(col,counto)
signal death
#Function for throwing a hook to one direction and pulling closer to it.
func hookDo():
    pass

func colorChanges():
	my_color = $Polygon2D.color
	colourSCount[0]  = my_color.r*4
	colourSCount[1] = my_color.g*4
	colourSCount[2] = my_color.b*4
	arrow_Colour()
	emit_signal("colourChanged",colourSelection,colourSCount[colourSelection])

func shoot():
	#if orbs_consumed >=1:
	if true:
		if colourSelection == 0 && my_color.r >= colourChunk :
			$Polygon2D.color = Color(my_color.r- colourChunk, my_color.g,my_color.b,my_color.a)

		elif colourSelection == 1 && my_color.g >= colourChunk:
			$Polygon2D.color = Color(my_color.r, my_color.g- colourChunk,my_color.b,my_color.a)

		elif colourSelection == 2 && my_color.b >= colourChunk:
			$Polygon2D.color = Color(my_color.r, my_color.g,my_color.b- colourChunk,my_color.a)

			 
		else:
			return
		var diriShoot = get_local_mouse_position()
		diriShoot = diriShoot.normalized()
		velocity -= diriShoot*shotBoostSpeed
		scale = scale - 0.2*Vector2(1,1)
		#orbs_consumed = orbs_consumed -1
		colorChanges()
		emit_signal("shoot_orb",diriShoot,colourSelection)

func _ready():
	print (self.owner)
	my_color = $Polygon2D.color
	#orbs_consumed=0
	colourSelection=0
	colourSCount = [0,0,0]
	colorChanges()
	not_stunned = 1
	connect("shoot_orb",self.owner,"_on_player_shoot_orb")
	connect("colourChanged",self.owner.get_node("HUD"),"_on_player_colourChanged")

func anim():
	var current = $AnimatedSprite.animation
	if velocity.x != 0:
		$AnimatedSprite.play("move")
	else:
		$AnimatedSprite.stop()
	
	if velocity.y < 0:
		$AnimatedSprite.play("jump")
	if velocity.y > 0:
		$AnimatedSprite.play("fall")
	
	if velocity.x < 0:
		$AnimatedSprite.scale.x = -0.1
	if velocity.x > 0:
		$AnimatedSprite.scale.x = 0.1

func _physics_process(delta):
	anim()
	if not_stunned == 0:
		timeStunned += delta
		if timeStunned >0.2:
			not_stunned = 1
			timeStunned =0
	if Input.is_action_just_pressed("cycle_modes"):
		colourSelection = (colourSelection+1)%3
		colorChanges()
	elif Input.is_action_just_pressed("Red_Mode"):
		colourSelection = 0
		colorChanges()
	elif Input.is_action_just_pressed("Green_Mode"):
		colourSelection =1
		colorChanges()
	elif Input.is_action_just_pressed("Blue_Mode"):
		colourSelection =2
		colorChanges()
	elif Input.is_action_just_pressed("alt_cycle_modes"):
		colourSelection = (2 + colourSelection)%3
		colorChanges()
	$arrow.look_at(get_global_mouse_position())
	#Jumping with Space
	if Input.is_action_pressed("ui_select") && (jumped == false || onWall == true):
		velocity.y = -jumpSpeed - BLUE_BONUS_TO_JUMP*colourSCount[2]
		jumped = true
		onWall = false
		concec_jumps = concec_jumps+1
	else:
		velocity.y += delta * GRAVITY
   #Left and Right Movement
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED -GREEN_BONUS_TO_SPEED*colourSCount[1]
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED  +GREEN_BONUS_TO_SPEED*colourSCount[1]
	else:
		velocity.x = velocity.x -velocity.x/10
    #Movement
	if Input.is_action_just_pressed("ui_shoot"):
		shoot()
	velocity.x = velocity.x*not_stunned
	velocity = get_floor_velocity()+velocity
	move_and_slide(velocity, Vector2(0, -1))
    
	#Checking when landing or when colliding with wall, ceilling.
	if is_on_floor():
		jumped = false
		velocity.y = 0
		concec_jumps=0
	if is_on_ceiling():
		velocity.y = delta* GRAVITY
	if is_on_wall():
		if concec_jumps < 2:
			onWall = true
		velocity.x = -velocity.x

func on_orb_taken(c,orbName):
	emit_signal("orb_was_taken")
	var modificus = 4
	#$Polygon2D.color = Color(my_color.r + c.r/modificus, my_color.g + c.g/modificus, my_color.b +c.b/modificus, my_color.a)
	$Polygon2D.color= Color(my_color.r +c.r/modificus,my_color.g +c.g/modificus, my_color.b +c.b/modificus,my_color.blend(c).a)
	scale = scale + 0.2*Vector2(1,1)*c.r + 0.2*Vector2(1,1)*c.g + 0.2*Vector2(1,1)*c.b
	#orbs_consumed= orbs_consumed+1
	colorChanges()

func arrow_Colour():
	if colourSelection ==0:
		$arrow.color = Color(float(1),0,0,1)
	elif colourSelection == 1:
		$arrow.color = Color(0,float(1),0,1)
	elif colourSelection == 2:
		$arrow.color = Color(0,0,float(1),1)

func damaged():
	if colourSCount[0] >0:
		if velocity.x >0:
			position.x -= 40
		elif velocity.x <0:
			position.x +=40
		not_stunned = 0
		velocity = -velocity
		$Polygon2D.color = Color(my_color.r- colourChunk, my_color.g,my_color.b,my_color.a)
		colorChanges()
	else:
		death()


func death():
	var tempLoad = load("res://death_screen.tscn").instance()
	tempLoad.set_name("death_screen")
	add_child(tempLoad)


func respawn():
	$Polygon2D.show()
	velocity = Vector2(0,0)
	scale = Vector2(2,2)
	var checkpoints =get_tree().get_nodes_in_group("Checkpoint")
	for i in checkpoints:
		if i.active == true:
			position = i.position
			$Polygon2D.color = Color(0,0,0,1)
			colorChanges()
			connect("death",i,"_on_player_death")
			emit_signal("death")
			return
	get_tree().reload_current_scene()
