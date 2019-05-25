extends "res://Drops/drop.gd"

var price = 15

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and body.get("arrows") < body.get("max_arrows"):
		body.give_arrows(5)
		_SIGNAL_MANAGER.update_AB()
		queue_free()

func give_to_player():
	_GLOBAL_DATA.player.give_arrows(5)
	_SIGNAL_MANAGER.update_AB()
	_SIGNAL_MANAGER.show(false, null, _TRANSLATION_MANAGER.translate(tr("ARROWS")))