extends Character
class_name Gunner

var touch : Array
func create():
	
	AD = 20 #공격력
	AD_1 = 2.0
	AD_2 = 1.5
	AD_3 = 2.5
	DP = 0
	
	NK = 20
	NK_1 = 40
	NK_2 = 20
	NK_3 = 40
	
	Skill_delay = [0,2,2,3]

func Attack():
	if is_attack : return
	is_attack = true
	body.get_node("AR").start()
	attackNum += 1
	if attackNum == 1:
		body.get_node("Anim").play("attack")
		await body.get_tree().create_timer(0.33).timeout
		var bullet = Global.bullet.instantiate()
		bullet.global_position = body.global_position + Vector2(0,-20)
		bullet.setting(body,Look)
		body.get_parent().add_child(bullet)
	elif attackNum == 2:
		body.get_node("Anim").play("attack2")
		await body.get_tree().create_timer(0.33).timeout
		var bullet = Global.bullet.instantiate()
		bullet.global_position = body.global_position + Vector2(0,-20)
		bullet.setting(body,Look)
		body.get_parent().add_child(bullet)
	else :
		body.get_node("Anim").play("attack3")
		await body.get_tree().create_timer(0.1).timeout
		for i in range(2):
			var bullet = Global.bullet.instantiate()
			bullet.global_position = body.global_position + Vector2(0,-20)
			bullet.setting(body,Look)
			body.get_parent().add_child(bullet)
			await body.get_tree().create_timer(0.3).timeout
		attackNum=0

	is_attack = false

func Skill1():
	if is_attack or Skill_On[1] != 0: return
	is_attack = true
	body.get_node("Anim").play("skill1")
	await body.get_tree().create_timer(0.5).timeout
	var mine = Global.mine.instantiate()
	mine.global_position = body.global_position
	mine.setting(body)
	body.get_parent().add_child(mine)
	is_attack = false
	Skill_On[1] = Skill_delay[1]
func Skill2():
	if is_attack or Skill_On[2] != 0: return
	is_attack = true
	body.get_node("AR").start()
	body.get_node("Anim").play("skill2")
	await dash(500,0.1,-Look)
	body.get_node("Area/S2/Collision").disabled = false
	await dash(0,0.4,-Look)
	await body.get_tree().create_timer(0.1).timeout
	is_attack = false
	body.get_node("Area/S2/Collision").disabled = true
	Skill_On[2] = Skill_delay[2]
	pass
func Skill3():
	if is_attack or Skill_On[3] != 0: return
	is_attack = true
	body.get_node("Anim").play("skill3")
	await body.get_tree().create_timer(0.6).timeout
	var bullet = Global.sp_bullet.instantiate()
	bullet.global_position = body.global_position
	bullet.setting(body,Look)
	body.get_parent().add_child(bullet)
	is_attack = false
	Skill_On[3] = Skill_delay[3]
	pass
