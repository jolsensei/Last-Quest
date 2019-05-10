extends Node

signal game_loaded

func _ready():
	_GLOBAL_DATA.map = $CurrentMap
	_GLOBAL_DATA.map.initialize()
	emit_signal("game_loaded")
	TranslationServer.set_locale(_GLOBAL_DATA.locale)
	get_tree().set_auto_accept_quit(false)
	
func _notification(what):
    if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
        _SAVE_SYSTEM.delete_temp()
		
