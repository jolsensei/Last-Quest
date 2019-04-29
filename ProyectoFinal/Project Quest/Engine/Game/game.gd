extends Node

signal game_loaded

func _ready():
	_GLOBAL_DATA.map = $CurrentMap
	_GLOBAL_DATA.map.initialize()
	emit_signal("game_loaded")
	TranslationServer.set_locale(_GLOBAL_DATA.locale)