extends CanvasLayer


func _on_player_rupee_picked():
	
	$Label.set_text(str(_GLOBAL_DATA.player.rupees))
		
	if _GLOBAL_DATA.player.rupees == _GLOBAL_DATA.player.max_rupees:
		$Label.set("custom_colors/font_color", Color.greenyellow)
	else:
		$Label.set("custom_colors/font_color", Color.white)


func _on_Game_game_loaded():
	$Label.set_text(str(_GLOBAL_DATA.player.rupees))
	_GLOBAL_DATA.player.connect("rupee_picked", self, "_on_player_rupee_picked")