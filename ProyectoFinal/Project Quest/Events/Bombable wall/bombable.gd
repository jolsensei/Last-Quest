extends StaticBody2D

func _on_Area2D_area_entered(area):
	if area.get_parent().get("type") == _ENUMS.TYPE.BOMB:
		_SFX.play_sfx("secret")
		queue_free()
