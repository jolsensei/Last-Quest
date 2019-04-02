extends Control

func _ready():
	_DIALOG_MANAGER.connect("send_dialog", self, "print_dialog")

func print_dialog(dialog):
	visible = not visible
	$Container/Label.text = dialog
	get_tree().paused = not get_tree().paused

