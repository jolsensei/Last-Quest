extends Node

signal loaded

export(String, FILE, "*.tscn") var NEW_MAP
export(String) var WARP_POSITION

var current_map = 0

func initialize():
	_GLOBAL_DATA.player = load_player()
#	_GLOBAL_DATA.map = load(NEW_MAP).instance()
	remove_child(_GLOBAL_DATA.player)
	startLevel(_GLOBAL_DATA.last_map, WARP_POSITION)
	
func startLevel(mapToWarp, position):
#We remove the player, then remove the map, to load the new map
#	_GLOBAL_DATA.map.remove_child(_GLOBAL_DATA.player)
#	remove_child(_GLOBAL_DATA.map)
#	_GLOBAL_DATA.map.queue_free()
	_GLOBAL_DATA.map = reload(mapToWarp)
	_GLOBAL_DATA.last_map = mapToWarp
	add_child(_GLOBAL_DATA.map)
	
#We add the player in the new map in the spawn position
	_GLOBAL_DATA.map.add_child(_GLOBAL_DATA.player)
	var spawn = _GLOBAL_DATA.map.get_node(position)
	_GLOBAL_DATA.player.position = (spawn.position)
	
	emit_signal("loaded")
	
	
func changeLevel(mapToWarp, position):
	save(_GLOBAL_DATA.last_map)
#We remove the player, then remove the map, to load the new map
	_GLOBAL_DATA.map.remove_child(_GLOBAL_DATA.player)
#	remove_child(_GLOBAL_DATA.map)
	_GLOBAL_DATA.map.queue_free()
	_GLOBAL_DATA.map = reload(mapToWarp)
	_GLOBAL_DATA.last_map = mapToWarp
	add_child(_GLOBAL_DATA.map)
	
#We add the player in the new map in the spawn position
	_GLOBAL_DATA.map.add_child(_GLOBAL_DATA.player)
	var spawn = _GLOBAL_DATA.map.get_node(position)
	_GLOBAL_DATA.player.position = (spawn.position)
	
	emit_signal("loaded")
	
func save(number):
	var scene = PackedScene.new()
	scene.pack(_GLOBAL_DATA.map)
	ResourceSaver.save("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/Temp/"+str(number)+".tscn", scene)
	
	
func reload(number):
	var scene = PackedScene.new()
	
	if Directory.new().file_exists("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/Temp/"+str(number)+".tscn"):
		scene = load("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/Temp/"+str(number)+".tscn")
		print("Temporal")
		return scene.instance()
	elif Directory.new().file_exists("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/RoomState/"+str(number)+".tscn"):
		scene = load("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/RoomState/"+str(number)+".tscn")
		return scene.instance()
		print("Guardado")
	else:
		print("Nuevo")
		return _GLOBAL_DATA.world[number].instance()

func load_player():
	if Directory.new().file_exists("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/Game/Player.tscn"):
		remove_child($Player)
		add_child(load("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/Game/Player.tscn").instance())

	return $Player