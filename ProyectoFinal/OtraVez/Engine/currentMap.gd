extends Node

export(String, FILE, "*.tscn") var NEW_MAP
export(String) var WARP_POSITION

func initialize():
	_GLOBAL_DATA.mapNode = load(NEW_MAP).instance()
	_GLOBAL_DATA.playerNode = $Player
	remove_child(_GLOBAL_DATA.playerNode)
	changeLevel(NEW_MAP, WARP_POSITION)
	
func changeLevel(mapToWarp, position):
		
#We remove the player, then remove the map, to load the new map
	_GLOBAL_DATA.mapNode.remove_child(_GLOBAL_DATA.playerNode)
	remove_child(_GLOBAL_DATA.mapNode)
	_GLOBAL_DATA.mapNode.queue_free()
	_GLOBAL_DATA.mapNode = load(mapToWarp).instance()
	add_child(_GLOBAL_DATA.mapNode)
	
#We add the player in the new map in the spawn position
	_GLOBAL_DATA.mapNode.add_child(_GLOBAL_DATA.playerNode)
	var spawn = _GLOBAL_DATA.mapNode.get_node(position)
	_GLOBAL_DATA.playerNode.position = (spawn.position)