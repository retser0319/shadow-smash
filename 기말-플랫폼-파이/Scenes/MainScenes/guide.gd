extends Node2D

var pageNum = 1
func _ready() -> void:
	get_node("Page2").visible = false
	$Back.visible = false
	if pageNum <= 1:
		pageNum = 1
	
func _on_texture_button_pressed() -> void:
	$Check.play()
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Title.tscn")


func _on_back_pressed() -> void:
	$Check.play()
	pageNum -= 1
	if (pageNum == 1):
		$Back.visible=false
		$Next.visible = true
		get_node("Page1").visible = true
		get_node("Page2").visible = false
	elif (pageNum == 2):
		get_node("Page1").visible = false
		get_node("Page2").visible = true
		$Back.visible = true
		$Next.visible = false
		

func _on_next_pressed() -> void:
	$Check.play()
	pageNum += 1
	if (pageNum == 2):
		get_node("Page1").visible = false
		get_node("Page2").visible = true
		$Next.visible = false
		$Back.visible = true
	elif (pageNum == 1):
		get_node("Page1").visible = true
		get_node("Page2").visible = false
		$Next.visible = true
		$Back.visible = false


func _on_title_mouse_entered() -> void:
	$Pop.play()


func _on_back_mouse_entered() -> void:
	$Pop.play()


func _on_next_mouse_entered() -> void:
	$Pop.play()
