extends Node

signal send_dialog
signal update_inventory
signal update_counter
signal update_AB
signal enter_animation
signal enter_finished
signal update_hearts

func show(sfx_activated, texture, text):
	
	emit_signal("send_dialog", sfx_activated, texture, text)

func update_inventory():
	emit_signal("update_inventory")
	
func update_counter(number, item):
	emit_signal("update_counter", number, item)
	
func update_AB():
	emit_signal("update_AB")

func enter_animation(warp_to, warp_position):
	emit_signal("enter_animation", warp_to, warp_position)
	
func update_hearts():
	emit_signal("update_hearts")
