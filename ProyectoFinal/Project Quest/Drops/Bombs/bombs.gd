extends "res://Drops/drop.gd"

var price = 20

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and body.get("bombs") < body.get("max_bombs"):
		body.give_bombs(5)
		_SIGNAL_MANAGER.update_AB()
		queue_free()

func give_to_player():
	_GLOBAL_DATA.player.give_bombs(5)
	_SIGNAL_MANAGER.update_AB()
	_SIGNAL_MANAGER.show(false, null, _TRANSLATION_MANAGER.translate(tr("5_BOMBS")))
