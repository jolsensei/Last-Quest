extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and _GLOBAL_DATA.player.boss_key:
		_SFX.play_sfx("use_key")
		queue_free()
