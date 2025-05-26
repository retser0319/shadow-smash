extends Node2D



var img = ["res://game dot/UI/FighterP.png","res://game dot/UI/gunnerP.png","res://game dot/UI/lancerP.png"]

var P1P = 1 #선택위치
var P2P = 3

var P1on = 0
var P2on = 0

var P1_is_Select = false #선택유무
var P2_is_Select = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Back"):
		get_tree().change_scene_to_file("res://Scenes/MainScenes/Title.tscn")
	P1select()
	P2select()
	if P1_is_Select == true and P2_is_Select == true:
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Scenes/MainScenes/battle.tscn")
	

func P1select():
	if Input.is_action_just_pressed("P1_MR") and P1_is_Select == false:
		if P1P>=3:return
		else:P1P += 1
	elif Input.is_action_just_pressed("P1_ML") and P1_is_Select == false:
		if P1P<=1:return
		else:P1P-=1
	$P1CHA.texture = load(img[P1P-1])
		
	if Input.is_action_just_pressed("P1_A"):
		if P1on == 0:
			P1_is_Select = true
			$SelectP1.texture = load("res://game dot/UI/SelectP1.2.png")
			if P1P == 1:
				Global.SelectP1 = "Fighter"
			elif P1P == 2:
				Global.SelectP1 = "Gunner"
			else :
				Global.SelectP1 = "Lancer"
			P1on = 1
		else :
			P1_is_Select = false
			$SelectP1.texture = load("res://game dot/UI/SelectP1.png")
			Global.SelectP1 = ""
			P1on = 0
	
	if P1P == 1:
		$SelectP1.position.x = 392
	elif P1P == 2:
		$SelectP1.position.x = 552
	else :
		$SelectP1.position.x = 712
	
	
	
func P2select():
	if Input.is_action_just_pressed("P2_MR") and P2_is_Select == false:
		if P2P>=3:return
		else:P2P += 1
	elif Input.is_action_just_pressed("P2_ML") and P2_is_Select == false:
		if P2P<=1:return
		else:P2P-=1
	$P2CHA.texture = load(img[P2P-1])
		
	if Input.is_action_just_pressed("P2_A"):
		if P2on == 0:
			P2_is_Select = true
			$SelectP2.texture = load("res://game dot/UI/SelectP2.2.png")
			P2on = 1
			if P2P == 1:
				Global.SelectP2 = "Fighter"
			elif P2P == 2:
				Global.SelectP2 = "Gunner"
			else :
				Global.SelectP2 = "Lancer"
		else :
			P2_is_Select = false
			$SelectP2.texture = load("res://game dot/UI/SelectP2.png")
			Global.SelectP2 = ""
			P2on = 0
	
	if P2P == 1:
		$SelectP2.position.x = 440
	elif P2P == 2:
		$SelectP2.position.x = 600
	else :
		$SelectP2.position.x = 760
	
