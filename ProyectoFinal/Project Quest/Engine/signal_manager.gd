extends Node

signal send_dialog
signal update_inventory

func show(text):
	
	emit_signal("send_dialog", text)

func update_inventory():
	emit_signal("update_inventory")