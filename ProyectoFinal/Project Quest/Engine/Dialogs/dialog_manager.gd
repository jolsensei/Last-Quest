extends Node

signal send_dialog

func show(text):
	
	emit_signal("show_dialog")