extends Node

signal send_dialog

func show(text):
	
	emit_signal("send_dialog", text)