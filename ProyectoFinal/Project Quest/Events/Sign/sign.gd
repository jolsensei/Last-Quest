extends "res://Events/basic_event.gd"

export(String) var text

func _input(event):
#	print("Test")
	if Input.is_action_just_pressed("a") and _GLOBAL_DATA.player.can_interact:
		_SIGNAL_MANAGER.show(false, null, _TRANSLATION_MANAGER.translate(tr(text)))


func _on_Area2D_body_entered(body):
	_on_body_entered(body)


func _on_Area2D_body_exited(body):
	_on_body_exited(body)
