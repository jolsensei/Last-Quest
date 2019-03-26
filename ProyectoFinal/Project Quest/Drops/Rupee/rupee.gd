extends Node

signal picked

func _ready():
	connect("body_entered", self , "body_entered")
	
func body_entered(body):
	if body.get("type") == "PLAYER" and body.get("rupees") < body.get("max_rupees"):
		body.add_rupees(1)
		queue_free()
