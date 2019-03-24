extends Node2D

func _ready():
	$Animation.play("default")
	$Animation.connect("animation_finished", self, "destroy")
	
func destroy(animation):
	queue_free()
