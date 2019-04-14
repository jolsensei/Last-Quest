extends "res://Drops/drop.gd"

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and body.get("rupees") < body.get("max_rupees"):
		body.add_rupees(1)
		queue_free()
		
func animation():
	$Animation.play("drop")

func give_to_player():
	if _GLOBAL_DATA.player.rupees < _GLOBAL_DATA.player.max_rupees:
		_GLOBAL_DATA.player.add_rupees(1)
	_SIGNAL_MANAGER.show(null, ["WoW, a single rupee, today is a day to celebrate"])