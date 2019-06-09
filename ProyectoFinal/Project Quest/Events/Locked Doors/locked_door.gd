extends StaticBody2D

export (String, FILE, "*.png") var sprite

func _ready():
	$Sprite.texture = load(sprite)

func _on_Area2D_body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and _GLOBAL_DATA.player.keys>0:
		_SFX.play_sfx("use_key")
#		_GLOBAL_DATA.player.keys -= 1
		_GLOBAL_DATA.player.add_keys(-1)
		queue_free()
