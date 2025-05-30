extends Area2D

var caster
var dir = 0

func _process(delta: float) -> void:
	$AnimatedSprite2D.play("needle")
	$AnimatedSprite2D2.play("needle")
	await get_tree().create_timer(0.35).timeout
	queue_free()

func setting(Cas):
	caster = Cas

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body != caster:
		body.C.onHit(caster.C.AD * caster.C.AD_3,caster.C.NK_3,caster.C.Look)
