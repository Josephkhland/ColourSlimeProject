extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var operating = false
var complete = false
var part2 = false
var time_between_colors = 1
var timePass =0
var timePass2=0
var timePass3=0
var LightGrowth =0.05
var MessageTitle 
var MessageText
var CatEyes

# Called when the node enters the scene tree for the first time.
func _ready():
	$Polygon2D.color = Color(0,0,0,1)
	$Polygon2D.offset = Vector2(0,100)
	$Light.offset = Vector2(0,100)
	$Light.color = $Polygon2D.color
	$Light.color.a = 0
	CatEyes = $Cute_eyes
	CatEyes.hide()
	MessageTitle = get_node("Message/Title")
	MessageText =get_node("Message/Text")
	MessageTitle.hide()
	MessageText.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timePass +=delta
	if operating == true && complete == true:
		timePass2 += delta
		timePass3 += delta
		if timePass3 >0.1:
			lightThing()
			timePass3 =0
		if timePass >3:
			CatEyes.hide()
			timePass =0
		if timePass2 >time_between_colors +0.5:
			CatEyes.show()
			timePass2= timePass
	if operating == true && complete == false && timePass >time_between_colors:
		timePass= 0
		lightThing()
		if Global.totalRed >0:
			Global.totalRed -=1
			$Polygon2D.color.r += 0.25
			$Light.color.r += 0.25
		elif Global.totalGreen >0:
			Global.totalGreen -=1
			$Polygon2D.color.g += 0.25
			$Light.color.g += 0.25
		elif Global.totalBlue >0:
			Global.totalBlue -=1
			$Polygon2D.color.b += 0.25
			$Light.color.b += 0.25
		elif part2 == false:
			CatEyes.show()
			MessageTitle.show()
			get_node("Message/Title/MarginContainer/Label").text = determineColor()
			part2 = true
		elif part2 == true:
			get_node("Message/Text/MarginContainer/Label").text =determineText(determineColor())
			MessageText.show()
			complete = true
			timePass2 = timePass
			Global.totalRed = $Polygon2D.color.r*4
			Global.totalGreen = $Polygon2D.color.g*4
			Global.totalBlue = $Polygon2D.color.b*4
	
func lightThing():
	if $Light.scale.x <= 1.5 && $Light.scale.x >=1:
		$Light.scale +=LightGrowth*Vector2(1,1)
	elif $Light.scale.x >1.5:
		LightGrowth = -LightGrowth
		$Light.scale = Vector2(1.5,1.5)
	elif $Light.scale.x <1:
		LightGrowth = -LightGrowth
		$Light.scale = Vector2(1,1)
	if $Light.color.a+LightGrowth>=0 || $Light.color.a+LightGrowth<=1:
		$Light.color.a +=LightGrowth

		

func _on_Node2D_body_entered(body):
	if body.get_name() == "player" && complete == false:
		operating = true
	elif body.get_name() == "player" && complete == true:
		MessageTitle.show()
		MessageText.show()

func determineColor():
	var r = $Polygon2D.color.r
	var g = $Polygon2D.color.g
	var b = $Polygon2D.color.b
	if r == 0 && g == 0 && b == 0:
		return "Black Slime"
	elif r==1 && g == 1 && b == 1:
		return "White Slime"
	elif r==g && g==b :
		return "Grey Slime"
	elif r <0.5 && g <0.5 && b <0.5:
		return "Dull Slime"
	elif r >= 1 && g<1 && b<1:
		return "Red Slime"
	elif r <1 && g>=1 && b <1:
		return "Green Slime"
	elif r <1 && g<1 && b >=1:
		return "Blue Slime"
	elif r==1.25 && g==1.25 && b == 1.25:
		return "Ultimate White Slime"
	elif r==1.25 && g==1.25 && b <1:
		return "Lemon Slime"
	elif r==1.25 && g<1 && b ==1.25:
		return "Candy Slime"
	elif r<1 && g==1.25 && b == 1.25:
		return "White Slime"
	elif r == g && b<r:
		return "Yellow Slime"
	elif r == b && g<r:
		return "Magenta Slime"
	elif g == b && r<g:
		return "Aqua Slime"
	
		

func determineText(coleur):
	if coleur == "Black Slime":
		return "Black Slimes are the Edgiest of them all!\nYour Powers include corroding as well\nas the power to inflict fear!"
	elif coleur == "White Slime":
		return "White Slimes are the pure and cheerful!\nYour Powers include shooting beams of light\nas well as the power to illuminate in\nthe dark!"
	elif coleur == "Grey Slime":
		return "Grey Slimes are Practical and Quiet!\nYour Powers include invisibility and getting things done!"
	elif coleur == "Dull Slime":
		return "Dull Slimes are Dull and boring!\nYour Powers include doing nothing and wasting your time!"
	elif coleur == "Red Slime":
		return "Red Slimes are Passionate and Courageous!\nYour Powers include shooting fire and pushing on!"
	elif coleur == "Green Slime":
		return "Green Slimes are Peaceful and Chill!\nYour Powers include ejecting sleep gas as well as\nsticking on surfaces!"
	elif coleur == "Blue Slime":
		return "Blue Slimes are Loyal and Cool!\nYour Powers include bouncing and freezing!"
	elif coleur == "Ultimate White Slime":
		return "You are one of the Rare Ultimate White Slimes!\n That means you have the ability to put your heart\n and soul into anything. Your Powers include\n flying, illuminating in the dark and teleporting!"
	elif coleur == "Lemon Slime":
		return "Lemon Slimes are Tasty and Cheerful!\n Your Powers include making Lemon Juice and partying!"
	elif coleur == "Candy Slime":
		return "Candy Slimes are the Cutest and Sweetest of them all!\n Your Powers include Charming and getting in a sugar rush!"
	elif coleur == "Yellow Slime":
		return "Yellow Slimes are Enthusiastic and full of energy!\n Your Powers include Electricity and Partying!"
	elif coleur == "Magenta Slime":
		return "Magenta Slimes are Sensitive and Loving!\n Your Powers include Healing and ... Self-destructing!"
	elif coleur == "Aqua Slime":
		return "Aqua Slimes are Fluid and Easy-going!\n Your Powers include turning into water...\n Be careful not to get drunk!"

func _on_Node2D_body_exited(body):
	if body.get_name() == "player" && complete == true:
		MessageTitle.hide()
		MessageText.hide()
