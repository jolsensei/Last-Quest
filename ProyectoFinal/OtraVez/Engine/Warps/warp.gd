extends Area2D

signal player_entered

export(String, FILE, "*.tscn") var warp_to
export(String) var warp_position

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			emit_signal("player_entered")
			_CURRENT_MAP.changeLevel(warp_to, warp_position)
