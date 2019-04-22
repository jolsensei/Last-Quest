extends "res://Drops/drop.gd"

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and body.get("keys") < body.get("max_keys"):
		_SFX.play_sfx("key")
		body.keys += 1
		queue_free()

func animation():
	$Animation.play("drop")
	
func give_to_player():
	_SFX.play_sfx("key")
	if _GLOBAL_DATA.player.keys < _GLOBAL_DATA.player.max_keys:
		_GLOBAL_DATA.player.keys += 1
	_SIGNAL_MANAGER.show(false, null, ["You found a small key! You can open a /*locked door*/ with it"])
