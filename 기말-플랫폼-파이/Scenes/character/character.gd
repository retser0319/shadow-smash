extends Node
class_name Character

var body
var attackNum = 0

var Life = 3
var is_death = false

var Gravity = 0  #중력
var RG = 0 #넉백저항
var AD = 20 #공격력
var AD_1 = 1.5
var AD_2 = 1.7
var AD_3 = 2

var NK = 0
var NK_1 = 0
var NK_2 = 0
var NK_3 = 0


var DP = 5 #방어력 : 공격력 - 방어력 += 넉백저항

var SP = 300 #이동속도
var JP = 250 #점프력

var Skill_delay = [0,2,2,2]
var Skill_On = [0,0,0,0]

var minus_delay 

var NOWSP = 0
var is_jump = false
var is_attack = false
var is_knockback =false
var is_dash = false

var dash_speed = 0

var NKstrengh = 0
var Look = 1

var Atimer = 0.5
var Delay = 0.2

func move(dir,y):
	Gravity -= 10
	if is_knockback: return Vector2(NKstrengh* 100,-Gravity*200)
	if is_dash: return Vector2(dash_speed * 100,0)
	if y and !is_jump: 
		is_jump = true
		Gravity = JP
	dir.y = -Gravity
	if dir.x != 0 and !is_attack:
		NOWSP = SP
	elif NOWSP > 0:
		NOWSP -= 15
		if NOWSP<10:
			NOWSP = 0
	return Vector2(Look * NOWSP * 100,dir.y * 200)

func anim(dir:Vector2):
	if is_attack : return
	if dir.x > 0 and !is_attack and !is_knockback and !is_dash:
		body.get_node("Anim").flip_h = false
		body.get_node("Area").scale.x = 3
		Look = 1

	elif dir.x < 0 and !is_attack and !is_knockback and !is_dash:
		body.get_node("Anim").flip_h = true
		body.get_node("Area").scale.x = -3
		Look = -1

	if is_knockback:
		body.get_node("Anim").play("hit")
	elif is_attack:
		body.get_node("Anim").play("attack")
	elif is_dash:
		body.get_node("Anim").play("dash")
	elif is_jump:
		body.get_node("Anim").play("jump")
	elif dir.x != 0:
		body.get_node("Anim").play("run")
	else:
		body.get_node("Anim").play("idle")

func recovery(heal):
	if RG-heal<=0:
		RG=0
	else:
		RG -= heal
	
func hit(dmg):
	if dmg<0:
		dmg=1
	
	if (dmg+RG<0):
		RG=0
	elif(dmg+RG>999):
		RG=999
	else:
		RG+=dmg

func onHit(dmg,NK,look):
	hit(dmg-DP)
	Knockback(NK,look)
	#상대 넉백데미지 주기
	
func Knockback(dmg,look):#넉백 시키는애 룩
	if look>0: look=1
	else: look=-1
	NKstrengh = RG * dmg *look / 15
	Gravity = RG * dmg / 25
	is_knockback = true
	body.get_node("NK").wait_time = (RG * dmg / 100)*0.005
	body.get_node("NK").start()
	
func stop_knockback():
	is_knockback = false
	NKstrengh = 0
	Gravity = 0
	body.get_node("NK").stop()

#포물선에서 날아갈때 최고점 찍고 기절 풀리기
func dash(SP,duraition,look):
	if look>0: dash_speed = SP
	else: dash_speed = -SP
	is_dash = true
	await body.get_tree().create_timer(duraition).timeout
	Gravity = 0
	is_dash = false

func coolTime(delta: float):
	for i in range(Skill_On.size()):
		if Skill_On[i] <= 0 : Skill_On[i] = 0
		else : Skill_On[i] -= delta
