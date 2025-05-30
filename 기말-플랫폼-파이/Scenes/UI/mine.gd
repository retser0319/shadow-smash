extends Area2D


var already_triggered = false
var touch : Array

var caster

var On = false

func _ready() -> void:
	await get_tree().create_timer(2).timeout
	On = true

func _process(delta: float):
	if !$RayCast2D.is_colliding():
		position.y += 2

func setting(Cas):
	caster = Cas
	
func _on_body_entered(body: Node) -> void:
	if already_triggered or !On:
		return
	if body.is_in_group("Player"):
		$AnimatedSprite2D.play()
		await get_tree().create_timer(0.3).timeout
		$Bombsound.play()
		for O in touch.size():
			touch[O].C.onHit(caster.C.AD*caster.C.AD_1,caster.C.NK_1,(touch[O].global_position.x - global_position.x))

			
		already_triggered = true
		await get_tree().create_timer(0.7).timeout
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.targetAdd(touch,body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	Global.targetRemove(touch,body)
