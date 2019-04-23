extends "res://Drops/drop.gd"

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		_SFX.play_sfx("heart_container")
		body.global_max_hearts += 1
		body.global_hearts = body.global_max_hearts
		_SIGNAL_MANAGER.update_hearts()
		show_text()
		queue_free()

func give_to_player():
	_SFX.play_sfx("heart_container")
	_GLOBAL_DATA.player.global_max_hearts += 1
	_GLOBAL_DATA.player.global_hearts = _GLOBAL_DATA.player.global_max_hearts
	_SIGNAL_MANAGER.update_hearts()
	show_text()

func show_text():
	_SIGNAL_MANAGER.show(false, $Portrait.texture, ["You got a /*heart container*/! You get a new /*full heart*/! That's great"])