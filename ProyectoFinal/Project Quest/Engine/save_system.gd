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
	
func delete_data(number): #This method deletes the selected savefile, be careful
	var dir = Directory.new()
	
	var count = 0
	while count < 10:
		dir.remove("res://Saves/Save"+str(number)+"/RoomState/"+str(count)+".tscn")
		count += 1
	dir.remove("res://Saves/Save"+str(number)+"/Game/Player.tscn")
	
func save_config():
	var config = File.new()
	var dir = Directory.new()
	config.open("res://Config/config.txt", File.WRITE)
	config.store_line(str(_GLOBAL_DATA.bgm_volume))
	config.store_line(str(_GLOBAL_DATA.sfx_volume))
	config.store_line(str(_GLOBAL_DATA.locale))
	config.close()
	
func load_config():
	var config = File.new()
	config.open("res://Config/config.txt", File.READ)
	var line_1 = config.get_line() #BGM
	_GLOBAL_DATA.bgm_volume = int(line_1)
	print(_GLOBAL_DATA.bgm_volume)
	
	var line_2 = config.get_line() #SFX
	_GLOBAL_DATA.sfx_volume = int(line_2)
	print(_GLOBAL_DATA.sfx_volume)
	
	var line_3 = config.get_line() #Language
	_GLOBAL_DATA.locale = line_3
	TranslationServer.set_locale(line_3)
	print(_GLOBAL_DATA.locale)
	config.close()