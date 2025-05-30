extends Character
class_name Lancer

var touch : Array

func create():
	AD = 25 #공격력
	AD_1 = 1
	AD_2 = 1.2
	AD_3 = 1.8
	DP = 10
	
	NK = 20
	NK_1 = 20
	NK_2 = 25
	NK_3 = 25
	
	Skill_delay = [0,2,2,2]

func Attack():
	if is_attack : return
	is_attack = true
	body.get_node("AR").start()
	attackNum += 1
	body.get_node("Area/NA/Collision").disabled = false
	if attackNum == 1:
		body.get_node("Anim").play("attack1")
		body.get_node("cut").play()
		await body.get_tree().create_timer(0.5).timeout
	elif attackNum == 2:
		body.get_node("Anim").play("attack2")
		body.get_node("cut").play()
		await body.get_tree().create_timer(0.5).timeout
	else :
		body.get_node("Anim").play("attack3")
		body.get_node("cut").play()
		await body.get_tree().create_timer(0.5).timeout
		attackNum=0
	is_attack = false
	body.get_node("Area/NA/Collision").disabled = true

func Skill1():
	if is_attack or Skill_On[1] != 0: return
	is_attack = true
	body.get_node("Anim").play("skill1")
	body.get_node("throw").play()
	await body.get_tree().create_timer(0.5).timeout
	var fly_lance = Global.fly_lance.instantiate()
	fly_lance.global_position = body.global_position + Vector2(0,-20)
	fly_lance.setting(body,Look)
	body.get_parent().add_child(fly_lance)
	is_attack = false
	Skill_On[1] = Skill_delay[1]
	pass
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
	#
	pass
func Skill3():
	if is_attack or Skill_On[3] != 0: return
	is_attack = true
	body.C.Gravity -= 250
	body.get_node("Anim").play("skill3")
	await body.get_tree().create_timer(0.5).timeout
	if body.C.is_jump == false:
		body.get_node("bomb").play()
		var needle = Global.needle.instantiate()
		needle.global_position = body.global_position + Vector2(0,2)
		needle.setting(body)
		body.get_parent().add_child(needle)
	is_attack = false
	Skill_On[3] = Skill_delay[3]
	pass
