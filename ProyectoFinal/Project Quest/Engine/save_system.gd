extends Node

func save_game():
	save_rooms_state()
	save_player()
	
func save_rooms_state():
	var dir = Directory.new()
	var count = 0
	var scene = PackedScene.new()
	
	scene.pack(_GLOBAL_DATA.map)
	ResourceSaver.save("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/Temp/"+str(_GLOBAL_DATA.last_map)+".tscn", scene)
	
	while count < 10:
		dir.copy("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/Temp/"+str(count)+".tscn", "res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/RoomState/"+str(count)+".tscn")
		count += 1
	
func save_player():
	var scene = PackedScene.new()
	_GLOBAL_DATA.player.last_map = _GLOBAL_DATA.last_map
	_GLOBAL_DATA.player.last_position = _GLOBAL_DATA.player.global_position
	_GLOBAL_DATA.player.hearts = _GLOBAL_DATA.player.global_hearts
	scene.pack(_GLOBAL_DATA.player)
	ResourceSaver.save("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/Game/Player.tscn", scene)
	
func delete_temp():
	var dir = Directory.new()
	
	var count = 0
	while count < 10:
		dir.remove("res://Saves/Save"+str(_GLOBAL_DATA.slot)+"/Temp/"+str(count)+".tscn")
		count += 1
	get_tree().quit()