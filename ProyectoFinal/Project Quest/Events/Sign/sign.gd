extends Node2D

export(String) var text
var can_read = false

func _ready():
	set_process_input(false) #This way _input is not called in every key input

func _on_Area2D_body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		close_to(true)


func _on_Area2D_body_exited(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		close_to(false)
		
func close_to(close):
		print("Close") if close else print("Far")
		_GLOBAL_DATA.player.can_read = close
		set_process_input(close)
		
func _input(event):
#	print("Test")
	if Input.is_action_just_pressed("a") and _GLOBAL_DATA.player.can_read:
		_DIALOG_MANAGER.show(["This is a test, you can press A to skip the following Lorem Ipsum so you know...", "Hope this works well"])
