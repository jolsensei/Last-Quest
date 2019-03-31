extends Node


func _on_map_loaded():
	if _GLOBAL_DATA.player.item_A != null:
		$ItemA.texture = _GLOBAL_DATA.player.item_A.instance().get_node("Sprite").texture
		$ItemA.hframes = _GLOBAL_DATA.player.item_A.instance().get_node("Sprite").hframes
		
	if _GLOBAL_DATA.player.item_B != null:
		$ItemB.texture = _GLOBAL_DATA.player.item_B.instance().get_node("Sprite").texture
		$ItemB.hframes = _GLOBAL_DATA.player.item_B.instance().get_node("Sprite").hframes
