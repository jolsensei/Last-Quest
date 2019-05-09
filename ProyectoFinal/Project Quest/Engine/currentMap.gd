extends Node

signal loaded

export(String, FILE, "*.tscn") var NEW_MAP
export(String) var WARP_POSITION

var current_map = 0

func initialize():
	_GLOBAL_DATA.player = $Player
	_GLOBAL_DATA.map = load(NEW_MAP).instance()
	remove_child(_GLOBAL_DATA.player)
	startLevel(current_map, WARP_POSITION)
	
func startLevel(mapToWarp, position):
#We remove the player, then remove the map, to load the new map
#	_GLOBAL_DATA.map.remove_child(_GLOBAL_DATA.player)
#	remove_child(_GLOBAL_DATA.map)
	_GLOBAL_DATA.map.queue_free()
	_GLOBAL_DATA.map = reload(mapToWarp)
	current_map = mapToWarp
	add_child(_GLOBAL_DATA.map)
	
#We add the player in the new map in the spawn position
	_GLOBAL_DATA.map.add_child(_GLOBAL_DATA.player)
	var spawn = _GLOBAL_DATA.map.get_node(position)
	_GLOBAL_DATA.player.position = (spawn.position)
	
	emit_signal("loaded")
	
	
func changeLevel(mapToWarp, position):
	save(current_map)
#We remove the player, then remove the map, to load the new map
	_GLOBAL_DATA.map.remove_child(_GLOBAL_DATA.player)
#	remove_child(_GLOBAL_DATA.map)
	_GLOBAL_DATA.map.queue_free()
	_GLOBAL_DATA.map = reload(mapToWarp)
	current_map = mapToWarp
	add_child(_GLOBAL_DATA.map)
	
#We add the player in the new map in the spawn position
	_GLOBAL_DATA.map.add_child(_GLOBAL_DATA.player)
	var spawn = _GLOBAL_DATA.map.get_node(position)
	_GLOBAL_DATA.player.position = (spawn.position)
	
	emit_signal("loaded")
	
func save(number):
	var scene = PackedScene.new()
	scene.pack(_GLOBAL_DATA.map)
	ResourceSaver.save("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/"+str(number)+".scn", scene)

func reload(number):
	var scene = PackedScene.new()
	scene = load("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/"+str(number)+".scn")
	if scene != null:
		return scene.instance()
	else:
		return _GLOBAL_DATA.world[number].instance()