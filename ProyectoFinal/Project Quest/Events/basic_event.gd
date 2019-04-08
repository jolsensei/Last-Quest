extends Node2D

func _ready():
	set_process_input(false) #This way _input is not called in every key input

func _on_body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		close_to(true)


func _on_body_exited(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		close_to(false)
		
func close_to(close):
		print("Close") if close else print("Far")
		_GLOBAL_DATA.player.can_interact = close
		set_process_input(close)
