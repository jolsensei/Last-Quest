extends Control

func _input(event):
	if Input.is_action_just_pressed("a"):
		get_tree().change_scene("res://Engine/Menus/Files/Files.tscn")
