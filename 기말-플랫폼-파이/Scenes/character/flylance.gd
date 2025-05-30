extends Area2D
var caster
var dir = 0

func _process(delta: float):
	position.x += dir * 1500 * delta
	$AnimatedSprite2D.play("fly")
	
func setting(Cas,di):
	caster = Cas
	dir = di

	if dir > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
func _on_body_entered(body: Node2D):
	if body.is_in_group("Player") and body != caster:
		body.C.onHit(caster.C.AD*caster.C.AD_1,caster.C.NK_1,caster.C.Look)
		queue_free()
	
	
