extends Node

signal loaded

export(String, FILE, "*.tscn") var NEW_MAP
export(String) var WARP_POSITION

func initialize():
	_GLOBAL_DATA.player = $Player
	_GLOBAL_DATA.map = load(NEW_MAP).instance()
	remove_child(_GLOBAL_DATA.player)
	changeLevel(NEW_MAP, WARP_POSITION)
	
func changeLevel(mapToWarp, position):
#We remove the player, then remove the map, to load the new map
	_GLOBAL_DATA.map.remove_child(_GLOBAL_DATA.player)
	remove_child(_GLOBAL_DATA.map)
	_GLOBAL_DATA.map.queue_free()
	_GLOBAL_DATA.map = load(mapToWarp).instance()
	add_child(_GLOBAL_DATA.map)
	
#We add the player in the new map in the spawn position
	_GLOBAL_DATA.map.add_child(_GLOBAL_DATA.player)
	var spawn = _GLOBAL_DATA.map.get_node(position)
	_GLOBAL_DATA.player.position = (spawn.position)
	
	emit_signal("loaded")