extends Node2D

func _ready():
	$Animation.play("default")
	$Animation.connect("animation_finished", self, "destroy")
	
func destroy(animation):
	queue_free()
	var drop = _DROP_MANAGER.random_drop()
	if drop != null:
		get_parent().add_child(drop)
		drop.animation()
		drop.global_transform = global_transform
