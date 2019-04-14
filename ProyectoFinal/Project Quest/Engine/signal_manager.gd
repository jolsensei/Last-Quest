extends Node

signal send_dialog
signal update_inventory

func show(texture, text):
	
	emit_signal("send_dialog", texture, text)

func update_inventory():
	emit_signal("update_inventory")