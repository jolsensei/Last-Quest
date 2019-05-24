extends Node2D

func give_to_player():
	_GLOBAL_DATA.player.max_rupees = 500
	_GLOBAL_DATA.player.add_rupees(0)
	_GLOBAL_DATA.player.big_wallet = true
	_SIGNAL_MANAGER.update_inventory()
	_SIGNAL_MANAGER.show(true, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("BIG_WALLET")))