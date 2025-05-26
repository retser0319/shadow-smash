extends CanvasLayer

var upgrade_can

var first_dead = ""

var is_wating = false

var position_P1 = 1
var position_P2 = 3

var SelectP1_card = false
var SelectP2_card = false

func _ready():
	position_P1 = 1
	position_P2 = 3
	
	SelectP1_card = false
	SelectP2_card = false
	Card_Shuffle()
	
func _process(delta: float):
	if get_parent().game_state == get_parent().Gamestate.Card \
	and SelectP1_card and SelectP2_card and !upgrade_can:
		upgrade_can = true
		get_parent().game_state = get_parent().Gamestate.Play
		upgrade_P1_ON()
		upgrade_P2_ON()
		await get_tree().create_timer(2).timeout
	#	$CardTscn.is_wating = true
		re_start()
		$SelectP1.texture = load("res://game dot/UI/SelectP1.png")
		$SelectP2.texture = load("res://game dot/UI/SelectP2.png")
		upgrade_can = false
	
	P1_Choice()
	P2_Choice()
	
		

func P1_Choice():
	SelectP1_card == false
	SelectP2_card == false
	
	if position_P1 == 1:
		$SelectP1.position.x = 137
	elif position_P1 == 2:
		$SelectP1.position.x = 500
	else :
		$SelectP1.position.x = 864
	
	if first_dead == "P2" and !SelectP2_card:
		return
	
	if Input.is_action_just_pressed("P1_MR") and SelectP1_card == false and get_tree().paused:
		if position_P1>=3:return
		else:position_P1 += 1
	elif Input.is_action_just_pressed("P1_ML") and SelectP1_card == false and get_tree().paused:
		if position_P1<=1:return
		else:position_P1-=1
		
	
	if SelectP1_card == false:
		$SelectP1.texture = load("res://game dot/UI/SelectP1.png")
	
	if Input.is_action_just_pressed("P1_A") and get_tree().paused:
		if SelectP2_card == true and position_P2 == position_P1:
			return
		print(str(position_P1))
			
		if SelectP1_card ==false:
			$SelectP1.texture = load("res://game dot/UI/SelectP1.2.png")
			SelectP1_card = true
			
		elif SelectP1_card == true:
			$SelectP1.texture = load("res://game dot/UI/SelectP1.png")
			SelectP1_card = false
	
	SelectP1_card == false
	SelectP2_card == false
		
func P2_Choice():
	SelectP2_card == false
	SelectP1_card == false
	
	if position_P2 == 1:
		$SelectP2.position.x = 290
	elif position_P2 == 2:
		$SelectP2.position.x = 654
	else :
		$SelectP2.position.x = 1017
		
	if first_dead == "P1" and !SelectP1_card:
		return
	
	if Input.is_action_just_pressed("P2_MR") and SelectP2_card == false:
		if position_P2>=3:return
		else:position_P2 += 1
	elif Input.is_action_just_pressed("P2_ML") and SelectP2_card == false:
		if position_P2<=1:return
		else:position_P2-=1
		
		
	if SelectP2_card == false:
		$SelectP2.texture = load("res://game dot/UI/SelectP2.png")
	
	if Input.is_action_just_pressed("P2_A") and get_tree().paused:
		if SelectP1_card == true and position_P1 == position_P2:
			return
			
		if SelectP2_card ==false:
			$SelectP2.texture = load("res://game dot/UI/SelectP2.2.png")
			SelectP2_card = true
			
		elif SelectP2_card == true:
			$SelectP2.texture = load("res://game dot/UI/SelectP2.png")
			SelectP2_card = false
		
		SelectP1_card == false
		SelectP2_card == false
		
func re_start():
		await get_tree().create_timer(0.3)
		SelectP1_card = false
		SelectP2_card = false
		position_P1 = 1
		position_P2 = 3
		
		$".".hide()
		get_tree().paused = false
		is_wating = false

func Card_Shuffle():
	var slots = [$HBoxContainer/Card1,$HBoxContainer/Card2,$HBoxContainer/Card3]
	slots.shuffle()
	
	var Card_type = ["Attack","Speed","Jump","Heal","Defense"]
	Card_type.shuffle()
	
	var select_type = Card_type.slice(0,3)
	
	for i in 3:
		var card = slots[i]
		var label = card.get_node("Label")
		var value = randi_range(1, 40)
		var type = select_type[i]
		
		card.set_meta("type",type)
		card.set_meta("value", value)
		
		match type:
			"Attack":
				value /=2
				label.text = "플레이어의 공격력이\n%d 증가합니다." % value
				card.set_meta("type", "Attack")
			"Speed":
				value *= 2
				label.text = "플레이어의 이동속도가\n%d 증가합니다." % value
				card.set_meta("type", "Speed")
			"Jump":
				label.text = "플레이어의 점프력이\n%d 증가합니다." % value
				card.set_meta("type", "Jump")
			"Heal":
				value*=2
				label.text = "플레이어의 체력이\n%d 회복됩니다." % value
				card.set_meta("type", "Heal")
			"Defense":
				value /=4
				label.text = "플레이어의 방어력이\n%d 증가합니다." % value
				card.set_meta("type", "Defense")
func card_random():
	Card_Shuffle()
	show()

func P1_upgrade():
	var cards = [
		$HBoxContainer/Card1,
		$HBoxContainer/Card2,
		$HBoxContainer/Card3
	]
	var card = cards[position_P1 - 1]
	return {
		"type" : card.get_meta("type"),
		"value" : card.get_meta("value")
	}

func P2_upgrade():
	var cards = [
		$HBoxContainer/Card1,
		$HBoxContainer/Card2,
		$HBoxContainer/Card3
	]
	var card = cards[position_P2 - 1]
	return {
		"type" : card.get_meta("type"),
		"value" : card.get_meta("value")
	}

func upgrade_P1_ON():
	var data = P1_upgrade()
	print(data["type"], data["value"])
	var type = data["type"]
	var value = data["value"]

	match type:
		"Attack":
			value/2
			get_parent().get_node("P1").C.AD += value
		"Speed":
			value *= 2
			get_parent().get_node("P1").C.SP += value
		"Jump":
			get_parent().get_node("P1").C.JP += value
		"Heal":
			value *= 2
			get_parent().get_node("P1").C.recovery(value)
		"Defense":
			value/4
			get_parent().get_node("P1").C.DP += value

	
func upgrade_P2_ON():
	var data = P2_upgrade()
	print(data["type"], data["value"])
	var type = data["type"]
	var value = data["value"]

	match type:
		"Attack":
			value/2
			get_parent().get_node("P2").C.AD += value
		"Speed":
			value *= 2
			get_parent().get_node("P2").C.SP += value
		"Jump":
			get_parent().get_node("P2").C.JP += value
		"Heal":
			value *= 2
			get_parent().get_node("P2").C.recovery(value)
		"Defense":
			value/4
			get_parent().get_node("P2").C.DP += value

	
func P1_first_pick():
	if SelectP1_card == false:
		P1_Choice()
	else:
		P2_Choice()
		
