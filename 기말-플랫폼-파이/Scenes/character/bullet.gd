extends Area2D

var caster
var dir = 0

func _process(delta: float):
	position.x += dir * 800 * delta
	
func setting(Cas,di):
	caster = Cas
	dir = di

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player") and body != caster:
		body.C.onHit(caster.C.AD,caster.C.NK,caster.C.Look)
		queue_free()
	
	
