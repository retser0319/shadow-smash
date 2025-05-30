extends Node2D

func _ready():
	var is_fullscreen = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	$Fullscreen.button_pressed = is_fullscreen

func _on_fullscreen_toggled(button_pressed: bool):
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if button_pressed
		else DisplayServer.WINDOW_MODE_WINDOWED
	)
	$check.play()


func _on_texture_button_pressed() -> void:
	$check.play()
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Title.tscn")


func _on_texture_button_mouse_entered() -> void:
	$Pop.play()
	pass # Replace with function body.
