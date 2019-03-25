extends CanvasLayer




func _on_map_loaded():
	$Label.set_text(str(_GLOBAL_DATA.player.rupees))
