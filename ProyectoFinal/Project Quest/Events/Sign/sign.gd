extends "res://Events/basic_event.gd"

export(String) var text

func _input(event):
#	print("Test")
	if Input.is_action_just_pressed("a") and _GLOBAL_DATA.player.can_interact:
		_SIGNAL_MANAGER.show(null, ["This is a test, you can press A to skip the following Lorem Ipsum so you know...", "Hope this works well"])


func _on_Area2D_body_entered(body):
	_on_body_entered(body)


func _on_Area2D_body_exited(body):
	_on_body_exited(body)
