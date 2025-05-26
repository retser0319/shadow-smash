extends Node2D

	

func _on_play_pressed() -> void:
	#캐릭터 선택 창 이동하기
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Caracterpick.tscn")


func _on_guide_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Guide.tscn")


func _on_setting_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Setting.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
