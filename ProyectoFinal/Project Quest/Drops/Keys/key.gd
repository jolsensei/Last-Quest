extends "res://Drops/drop.gd"

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and body.get("keys") < body.get("max_keys"):
		body.keys += 1
		queue_free()

func animation():
	$Animation.play("drop")
	
func give_to_player():
	if _GLOBAL_DATA.player.keys < _GLOBAL_DATA.player.max_keys:
		_GLOBAL_DATA.player.keys += 1
	_SIGNAL_MANAGER.show(null, ["You found a small key! You can open a /*locked door*/ with it"])
