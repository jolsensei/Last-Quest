extends Area2D

signal player_entered

enum WORLDS{BEACH, OVERWORLD, TOWN, CAVES, GOLDY, MOUNTAIN, DUNGEON}

#export(String, FILE, "*.tscn") var warp_to
export(WORLDS) var warp_to
export(String) var warp_position
export(String) var zone_name
export(bool) var show_keys

func _init():
	set_physics_process(false)

func _ready():
	_CURRENT_MAP.connect("loaded", self, "map_loaded")

func map_loaded():
	set_physics_process(true)

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			Input.action_release("r")
			_SIGNAL_MANAGER.enter_animation(warp_to, warp_position, tr(zone_name))
			emit_signal("player_entered")
			body.hands_free = true
			body.can_interact = true
			_SIGNAL_MANAGER.show_keys(show_keys)
			
			match(warp_to):
				WORLDS.OVERWORLD:
					_BGM.play_bgm("overworld")
				WORLDS.TOWN:
					_BGM.play_bgm("town")
				WORLDS.BEACH:
					_BGM.play_bgm("beach")
				WORLDS.CAVES:
					_BGM.play_bgm("caves")
				WORLDS.MOUNTAIN:
					_BGM.play_bgm("mountain")
				WORLDS.DUNGEON:
					_BGM.play_bgm("dungeon")
