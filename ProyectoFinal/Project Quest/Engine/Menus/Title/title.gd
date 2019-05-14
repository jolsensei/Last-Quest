extends Control

func _ready():
	_SAVE_SYSTEM.load_config()
	$Animation.play("version")
	$CenterContainer2/Label.text = tr("T_PRESS_BUTTON")

func _input(event):
	if Input.is_action_just_pressed("a"):
		get_tree().change_scene("res://Engine/Menus/Files/Files.tscn")

func _on_Animation_animation_finished(anim_name):
	match(anim_name):
		"logo":
			$Animation.play("press")
		"version":
			$Animation.play("logo")
