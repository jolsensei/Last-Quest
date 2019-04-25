extends "res://Drops/drop.gd"

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		_SFX.play_sfx("heart_piece")
		body.heart_pieces+= 1
		piece_switch(body)
		queue_free()

func give_to_player():
	_SFX.play_sfx("heart_piece")
	_GLOBAL_DATA.player.heart_pieces+= 1
	piece_switch(_GLOBAL_DATA.player)
	

func piece_switch(player):
	match(player.heart_pieces):
		1:
			_SIGNAL_MANAGER.show(false, $Portrait.texture, ["You got a /*heart piece*/! Get 3 more to get a /*full heart*/"])
		2:
			_SIGNAL_MANAGER.show(false, $Portrait.texture, ["You got a /*heart piece*/! Get 2 more to get a /*full heart*/"])
		3:
			_SIGNAL_MANAGER.show(false, $Portrait.texture, ["You got a /*heart piece*/! Get 1 more to get a /*full heart*/"])
		4:
			_SIGNAL_MANAGER.show(false, $Portrait.texture, ["You got a /*heart piece*/! You get a /*full heart*/!"])
			player.global_max_hearts += 1
			player.global_hearts = player.global_max_hearts
			player.heart_pieces = 0
			_SIGNAL_MANAGER.update_hearts()
	_SIGNAL_MANAGER.update_collection()