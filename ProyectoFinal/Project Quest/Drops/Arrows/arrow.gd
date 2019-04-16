extends "res://Drops/drop.gd"

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and body.get("arrows") < body.get("max_arrows"):
		body.give_arrows(5)
		_SIGNAL_MANAGER.update_AB()
		queue_free()

