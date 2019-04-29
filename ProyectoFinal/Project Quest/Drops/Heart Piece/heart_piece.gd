extends "res://Drops/drop.gd"

var ready_to_free = false

func _ready():
	_SIGNAL_MANAGER.connect("dialog_finished", self, "dialog_finished")

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		_SFX.play_sfx("heart_piece")
		body.heart_pieces+= 1
		piece_switch(body)
		body.can_interact = true
		ready_to_free = true

func give_to_player():
	_SFX.play_sfx("heart_piece")
	_GLOBAL_DATA.player.heart_pieces+= 1
	piece_switch(_GLOBAL_DATA.player)


func piece_switch(player):
	match(player.heart_pieces):
		1:
			_SIGNAL_MANAGER.show(false, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("HEART_PIECE_1")))
		2:
			_SIGNAL_MANAGER.show(false, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("HEART_PIECE_2")))
		3:
			_SIGNAL_MANAGER.show(false, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("HEART_PIECE_3")))
		4:
			_SIGNAL_MANAGER.show(false, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("HEART_PIECE_4")))
			player.global_max_hearts += 1
			player.global_hearts = player.global_max_hearts
			player.heart_pieces = 0
			_SIGNAL_MANAGER.update_hearts()
	_SIGNAL_MANAGER.update_collection()

func dialog_finished():
	if ready_to_free:
		_GLOBAL_DATA.player.can_interact = false
		queue_free()