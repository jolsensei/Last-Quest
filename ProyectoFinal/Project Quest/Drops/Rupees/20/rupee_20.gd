extends "res://Drops/drop.gd"

func give_to_player():
	_SFX.play_sfx("rupee")
	_GLOBAL_DATA.player.add_rupees(20)
	_SIGNAL_MANAGER.show(false, null, _TRANSLATION_MANAGER.translate(tr("RUPEE_20")))
