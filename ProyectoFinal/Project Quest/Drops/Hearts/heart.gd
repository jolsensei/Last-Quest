extends "res://Drops/drop.gd"

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and body.get("global_hearts") < body.get("global_max_hearts"):
		_SFX.play_sfx("heart")
		body.heal(1)
		queue_free()

func animation():
	$Animation.play("drop")
	
func give_to_player():
	_SFX.play_sfx("heart")
	if _GLOBAL_DATA.player.global_hearts < _GLOBAL_DATA.player.global_max_hearts:
		_GLOBAL_DATA.player.heal(1)
	_SIGNAL_MANAGER.show(false, null, _TRANSLATION_MANAGER.translate(tr("HEART")))