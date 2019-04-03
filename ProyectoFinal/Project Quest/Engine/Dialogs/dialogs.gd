extends Control

var is_paused = false

func _ready():
	_DIALOG_MANAGER.connect("send_dialog", self, "print_dialog")

func print_dialog(dialog):
	visible = true
	
	get_tree().paused = true
	
	$Container/Label.text = dialog
	
	is_paused = true
	


