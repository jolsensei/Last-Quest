extends "res://Events/basic_event.gd"

var opened = false

func _input(event):
#	print("Test")
	if Input.is_action_just_pressed("a") and _GLOBAL_DATA.player.can_interact and !opened:
		
		$Sprite.frame = 1
		_DIALOG_MANAGER.show(["This bitch empty... YAY"])
		opened = true

func _on_Area2D_body_entered(body):
	_on_body_entered(body)


func _on_Area2D_body_exited(body):
	_on_body_exited(body)
