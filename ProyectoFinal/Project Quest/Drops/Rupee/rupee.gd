extends Node

func _ready():
	connect("body_entered", self , "body_entered")
	
func body_entered(body):
	if body.get("type") == "PLAYER" and body.get("rupees") < body.get("max_rupees"):
		body.rupees +=1
		queue_free()
