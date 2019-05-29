extends Node

signal game_loaded

enum WORLDS{BEACH, OVERWORLD, TOWN, CAVES, GOLDY, DUNGEON}

func _ready():
	_GLOBAL_DATA.map = $CurrentMap
	_GLOBAL_DATA.map.initialize()
	emit_signal("game_loaded")
	TranslationServer.set_locale(_GLOBAL_DATA.locale)
	get_tree().set_auto_accept_quit(false)
	if _GLOBAL_DATA.player_name != null:
		_GLOBAL_DATA.player.player_name = _GLOBAL_DATA.player_name
		
	match(_GLOBAL_DATA.last_map):
				WORLDS.OVERWORLD:
					_BGM.play_bgm("overworld")
				WORLDS.TOWN:
					_BGM.play_bgm("town")
				WORLDS.BEACH:
					_BGM.play_bgm("beach")
				WORLDS.CAVES:
					_BGM.play_bgm("caves")
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_SAVE_SYSTEM.delete_temp()
		get_tree().quit()

