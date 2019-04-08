extends Node


func _on_map_loaded():
	if _GLOBAL_DATA.player.item_A != null:
		$ItemA.texture = _GLOBAL_DATA.player.item_A.instance().get_node("Portrait").texture
	else:
		$ItemA.texture = load("res://Engine/Pause/empty.png")
	if _GLOBAL_DATA.player.item_B != null:
		$ItemB.texture = _GLOBAL_DATA.player.item_B.instance().get_node("Portrait").texture
	else:
		$ItemB.texture = load("res://Engine/Pause/empty.png")


func _on_PauseInventory_equipment_changed():
	_on_map_loaded()
