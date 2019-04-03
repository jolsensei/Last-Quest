extends Node2D

var can_read = false


func _on_Area2D_body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		print("Near")
		_GLOBAL_DATA.player.can_read = true


func _on_Area2D_body_exited(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		print("Far")
		_GLOBAL_DATA.player.can_read = false
		
func _input(event):
	if Input.is_action_just_pressed("a") and _GLOBAL_DATA.player.can_read:
		_DIALOG_MANAGER.show("Hello, this is your first sign :D")
