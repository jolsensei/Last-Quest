extends Node2D

func _ready():
	$Animation.connect("animation_finished", self, "destroy")
	$Animation.play(str("sword_", get_parent().spriteMov))
	
func destroy(animation):
	queue_free()
	
