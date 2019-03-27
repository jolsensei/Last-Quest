extends "res://Drops/drop.gd"

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and body.get("global_hearts") < body.get("global_max_hearts"):
		body.heal(1)
		queue_free()
