extends CharacterBody2D
var C : Character
var playerNum

func _process(delta: float) -> void:
	C.coolTime(delta)

func Setting():
	if playerNum == 1:
		if Global.SelectP1 == "Fighter":
			C = Fighter.new()
			C.create()
			$Anim.sprite_frames = Global.trs_fighter
			add_child(Global.Area_fighter.instantiate())
			$Area/NA.connect("body_entered",Attackarea)
			$Area/S1.connect("body_entered",Skill1area)
			$Area/S2.connect("body_entered",Skill2area)
			$Area/S3.connect("body_entered",Skill3area)
		elif Global.SelectP1 == "Gunner":
			C = Gunner.new()
			C.create()
			$Anim.sprite_frames = Global.trs_gunner
			add_child(Global.Area_gunner.instantiate())
			$Area/S2.connect("body_entered",Skill2area)
		elif Global.SelectP1 == "Lancer" :
			C = Lancer.new()
			C.create()
			$Anim.sprite_frames = Global.trs_lancer
			add_child(Global.Area_lancer.instantiate())
			$Area/NA.connect("body_entered",Attackarea)
			$Area/S2.connect("body_entered",Skill2area)
	
	if playerNum == 2:
		if Global.SelectP2 == "Fighter":
			C = Fighter.new()
			C.create()
			$Anim.sprite_frames = Global.trs_fighter
			add_child(Global.Area_fighter.instantiate())
			$Area/NA.connect("body_entered",Attackarea)
			$Area/S1.connect("body_entered",Skill1area)
			$Area/S2.connect("body_entered",Skill2area)
			$Area/S3.connect("body_entered",Skill3area)
			
		elif Global.SelectP2 == "Gunner":
			C = Gunner.new()
			C.create()
			$Anim.sprite_frames = Global.trs_gunner
			add_child(Global.Area_gunner.instantiate())
			$Area/S2.connect("body_entered",Skill2area)
		elif Global.SelectP2 == "Lancer" :
			C = Lancer.new()
			C.create()
			$Anim.sprite_frames = Global.trs_lancer
			add_child(Global.Area_lancer.instantiate())
			$Area/NA.connect("body_entered",Attackarea)
			$Area/S2.connect("body_entered",Skill2area)
			
	C.body = self
func _physics_process(delta: float):
	if playerNum == 1 : P1_Control(delta)
	elif playerNum == 2 : P2_Control(delta)
	

func P1_Control(delta) :
	var x = Input.get_axis("P1_ML", "P1_MR")
	var y = Input.is_action_pressed("P1_J")
	C.anim(Vector2(x,y))
	velocity = C.move(Vector2(x,0),y) * delta
	move_and_slide()
	
	if Input.is_action_pressed("P1_J") and C.is_jump:
		$JUMP.play()
	if is_on_floor():
		C.is_jump = false
		C.Gravity = 0
	
	if Input.is_action_just_pressed("P1_DASH") and !C.is_attack:
		$Dash.play()
		C.dash(300,0.5,C.Look)
	
	if Input.is_action_pressed("P1_A") and !C.is_attack:
		C.Attack()
		
	if Input.is_action_pressed("P1_S1") and !C.is_attack:
		C.Skill1()	
		
	if Input.is_action_pressed("P1_S2") and !C.is_attack:
		C.Skill2()
	
	if Input.is_action_pressed("P1_S3") and !C.is_attack:
		C.Skill3()
			
func P2_Control(delta) :
	var x = Input.get_axis("P2_ML", "P2_MR")
	var y = Input.is_action_pressed("P2_J")
	C.anim(Vector2(x,y))
	velocity = C.move(Vector2(x,0),y)* delta
	move_and_slide()
	
	if Input.is_action_pressed("P2_J") and C.is_jump:
		$JUMP.play()
		
	if is_on_floor():
		C.is_jump = false
		C.Gravity = 0
	
	if Input.is_action_just_pressed("P2_DASH") and !C.is_attack:
		$Dash.play()
		C.dash(300,0.5,C.Look)
	
	if Input.is_action_pressed("P2_A") and !C.is_attack:
		C.Attack()
		
	if Input.is_action_pressed("P2_S1") and !C.is_attack:
		C.Skill1()	
		
	if Input.is_action_pressed("P2_S2") and !C.is_attack:
		C.Skill2()
	
	if Input.is_action_pressed("P2_S3") and !C.is_attack:
		C.Skill3()
	

func Attackarea(body: Node2D): #맞은 애
	if body.is_in_group("Player") and body != self:
		body.C.onHit(C.AD,C.NK,C.Look)

func Skill1area(body: Node2D) : #맞은 애
	if body.is_in_group("Player") and body != self:
		body.C.onHit(C.AD*C.AD_1,C.NK_1,C.Look)

func Skill2area(body: Node2D): #맞은 애
	if body.is_in_group("Player") and body != self:
		body.C.onHit(C.AD*C.AD_2,C.NK_2,C.Look)
		
func Skill3area(body: Node2D): #맞은 애
	if body.is_in_group("Player") and body != self:
		body.C.onHit(C.AD*C.AD_3,C.NK_3,C.Look)

func Attack_Reset():
	C.attackNum = 0

func _on_nk_timeout():
	C.is_knockback = false
	pass # Replace with function body.
