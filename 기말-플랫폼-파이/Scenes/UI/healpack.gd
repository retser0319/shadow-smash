extends Area2D

var already_triggered = false

func _ready():
	$AnimatedSprite2D.play()
	
	
func _on_body_entered(body: Node2D) -> void:
	if already_triggered or !body.is_in_group("Player"): return
	body.C.recovery(50)
	already_triggered = true
	visible = false
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(10).timeout
	visible = true
	$CollisionShape2D.disabled = false
	already_triggered = false
