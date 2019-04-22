extends Area2D

signal player_entered

export(String, FILE, "*.tscn") var warp_to
export(String) var warp_position

func _ready():
	_SIGNAL_MANAGER.connect("enter_finished", self, "enter_finished") 

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			_SIGNAL_MANAGER.enter_animation(warp_to, warp_position)
			emit_signal("player_entered")