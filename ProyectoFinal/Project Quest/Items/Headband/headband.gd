extends Node2D

func give_to_player():
	_GLOBAL_DATA.player.head_band = true
	_SIGNAL_MANAGER.update_inventory()
	_SIGNAL_MANAGER.show(true, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("HEADBAND")))
