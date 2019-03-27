extends "res://Drops/drop.gd"

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and body.get("rupees") < body.get("max_rupees"):
		body.add_rupees(1)
		queue_free()
		
func animation():
	$Animation.play("drop")
