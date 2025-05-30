extends Character
class_name Fighter

var touch : Array

func create():
	AD = 30 #공격력
	AD_1 = 1.5
	AD_2 = 1.2
	AD_3 = 1.8
	DP = 5
	
	NK = 20
	NK_1 = 35
	NK_2 = 30
	NK_3 = 35
	
	Skill_delay = [0,1,2,1]
	
func Attack():
	if is_attack : return
	is_attack = true
	body.get_node("AR").start()
	body.get_node("Punch").play()
	attackNum += 1
	body.get_node("Area/NA/Collision").disabled = false
	if attackNum != 3:
		body.get_node("Anim").play("attack")
		body.get_node("Punch").play()
		await body.get_tree().create_timer(0.33).timeout
	else :
		body.get_node("Anim").play("attack2")
		body.get_node("Punch").play()
		await body.get_tree().create_timer(0.5).timeout
		attackNum=0
	is_attack = false
	body.get_node("Area/NA/Collision").disabled = true
	#잽날리기
func Skill1():
	if is_attack or Skill_On[1] != 0: return
	is_attack = true
	body.get_node("AR").start()
	body.get_node("Area/S1/Collision").disabled = false
	body.get_node("Anim").play("skill1")
	await body.get_tree().create_timer(0.5).timeout
	body.get_node("Punch").play()
	is_attack = false
	body.get_node("Area/S1/Collision").disabled = true
	Skill_On[1] = Skill_delay[1]
	
func Skill2():
	if is_attack or Skill_On[2] != 0: return
	is_attack = true
	body.get_node("AR").start()
	body.get_node("Area/S2/Collision").disabled = false
	body.get_node("Anim").play("skill2")
	body.get_node("Dash").play()
	await dash(500,0.5,Look)
	is_attack = false
	body.get_node("Area/S2/Collision").disabled = true
	Skill_On[2] = Skill_delay[2]
	
func Skill3():
	if is_attack or Skill_On[3] != 0: return
	is_attack = true
	body.get_node("AR").start()
	body.get_node("Area/S3/Collision").disabled = false
	body.get_node("Anim").play("skill3")
	body.get_node("Punch").play()
	await body.get_tree().create_timer(0.5).timeout
	is_attack = false
	body.get_node("Area/S3/Collision").disabled = true
	Skill_On[3] = Skill_delay[3]
	
