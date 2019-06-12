extends Area2D

func give_to_player():
	_SFX.play_sfx("key")
	_GLOBAL_DATA.player.boss_key = true
	_SIGNAL_MANAGER.show(false, null, _TRANSLATION_MANAGER.translate(tr("BOSS_KEY")))
