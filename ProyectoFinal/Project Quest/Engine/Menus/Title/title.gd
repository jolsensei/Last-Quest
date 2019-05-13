extends Control

func _ready():
	$Animation.play("version")

func _input(event):
	if Input.is_action_just_pressed("a"):
		get_tree().change_scene("res://Engine/Menus/Files/Files.tscn")

func _on_Animation_animation_finished(anim_name):
	match(anim_name):
		"logo":
			$Animation.play("press")
		"version":
			$Animation.play("logo")
