extends Control


func _ready() -> void:
	winner()
	
	
func _process(delta: float) -> void:
	pass
	
func winner():
	if Global.winner == 1:
		$"Winner is/WhoP".texture = load("res://game dot/shadow/UI/WinP1.png")
	elif Global.winner == 2:
		$"Winner is/WhoP".texture = load("res://game dot/shadow/UI/WinP2.png")
	


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Title.tscn")
