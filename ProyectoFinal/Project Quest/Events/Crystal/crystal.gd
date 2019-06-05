extends Node2D

export var event_to_open = ""
export var activated = false

func _ready():
	if activated:
		$Animation.play("default")

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("boomerang"):
		if !activated:
			$Animation.play("default")
			_SFX.play_sfx("secret")
			get_parent().get_node(event_to_open).queue_free()
			activated = true
