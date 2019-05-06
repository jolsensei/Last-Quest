extends CanvasLayer


func _on_player_rupee_picked():
	if _GLOBAL_DATA.player.rupees > 9:
		$Label.set_text("0" + str(_GLOBAL_DATA.player.rupees))
	else:
		$Label.set_text("00" + str(_GLOBAL_DATA.player.rupees))
		
	if _GLOBAL_DATA.player.rupees == _GLOBAL_DATA.player.max_rupees:
		$Label.set("custom_colors/font_color", Color.greenyellow)
