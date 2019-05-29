extends StaticBody2D

export (String, FILE, "*.png") var sprite

func _ready():
	$Sprite.texture = load(sprite)

func _on_Area2D_area_entered(area):
	if area.get_parent().get("type") == _ENUMS.TYPE.BOMB:
		_SFX.play_sfx("secret")
		queue_free()
