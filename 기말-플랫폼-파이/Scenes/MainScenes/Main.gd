extends Node2D

var p1
enum Gamestate {Play,Card} #배틀 or 증강
var game_state = Gamestate.Play #현재상태
var winner = 1

func _init() -> void:
	pass
	
func _process(delta: float):
	P1death()
	P2death()
	
func _ready() -> void:
	
	$CardTscn.SelectP1_card = false
	$CardTscn.SelectP2_card = false
	$P1.playerNum = 1
	$P2.playerNum = 2
	
	$P1.Setting()
	$P2.Setting()
	
	

func P1death():
	if $P1.position.y > get_viewport_rect().size.y :
		if !$P1.C.is_death:
			$P1.C.Life -= 1
			$P1.C.RG = 0
			if $P1.C.Life < -1:
				$P1.C.Life = -1
			$P1.C.is_death = true
			
			if $P1.C.Life ==-1:
				game_set()
				return
				
			$P1.position.x = 171
			$P1.position.y = 486
			
			$P2.position.x = 924
			$P2.position.y = 486
			
			$P1.C.stop_knockback()
			$P2.C.stop_knockback()
			
			game_state = Gamestate.Card
			get_tree().paused = true
			$CardTscn.show()
			$CardTscn.card_random()
			$CardTscn.first_dead = "P1"
		
			
	else:
		$P1.C.is_death = false

func P2death():
	if $P2.position.y > get_viewport_rect().size.y :
		
		if !$P2.C.is_death:
			$P2.C.Life -= 1
			$P2.C.RG = 0
			
			if $P2.C.Life < -1:
				$P2.C.Life = -1
			$P2.C.is_death = true
			
			if $P2.C.Life ==-1:
				game_set()
				return
				
			$P1.position.x = 171
			$P1.position.y = 484
			$P2.position.x = 924
			$P2.position.y = 484
			
			$P1.C.stop_knockback()
			$P2.C.stop_knockback()
			
			game_state = Gamestate.Card
			get_tree().paused = true
			$CardTscn.show()
			$CardTscn.card_random()
			$CardTscn.first_dead = "P2"
			
	else:
		$P2.C.is_death = false
		
		
func game_set():
	get_tree().paused = false
	await get_tree().create_timer(0.1).timeout
	if $P1.C.Life == -1:
		Global.winner = 2
		get_tree().change_scene_to_file("res://Scenes/Winner.tscn")
	elif $P2.C.Life == -1:
		await get_tree().create_timer(0.1).timeout
		Global.winner = 1
		get_tree().change_scene_to_file("res://Scenes/Winner.tscn")
	
