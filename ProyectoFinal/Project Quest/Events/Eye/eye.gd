extends Node2D
export var event_to_open = ""
export var activated = false

func _ready():
	if activated:
		$Sprite.frame = 1

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("destroy_on_hit"):
		if !activated:
			$Sprite.frame = 1
			_SFX.play_sfx("secret")
			get_parent().get_node(event_to_open).queue_free()
			activated = true
