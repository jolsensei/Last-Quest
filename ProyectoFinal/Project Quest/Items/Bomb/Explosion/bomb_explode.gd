extends Node2D

var damage = 2
var type = _ENUMS.TYPE.BOMB

func _ready():
	$Animation.play("explode")
	$Animation.connect("animation_finished", self, "destroy")
	
func destroy(animation):
	queue_free()
