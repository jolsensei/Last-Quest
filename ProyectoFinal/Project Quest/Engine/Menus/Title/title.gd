extends Control

func _ready():
	_SAVE_SYSTEM.load_config()
	$Animation.play("version")
	$CenterContainer2/Label.text = tr("T_PRESS_BUTTON")
	_BGM.play_bgm("title")
	check_dir_existance()
	print(OS.get_user_data_dir())

func _input(event):
	if Input.is_action_just_pressed("a"):
		_SFX.play_sfx("cursor")
		_BGM.stop_bgm()
		_BGM.play_bgm("files")
		get_tree().change_scene("res://Engine/Menus/Files/Files.tscn")

func _on_Animation_animation_finished(anim_name):
	match(anim_name):
		"logo":
			$Animation.play("press")
		"version":
			$Animation.play("logo")
			
func check_dir_existance():
	var dir = Directory.new()
	
	if !dir.dir_exists(OS.get_user_data_dir() + "/Saves"):
		dir.make_dir(OS.get_user_data_dir() + "/Saves")
		
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save1")
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save1/Game")
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save1/RoomState")
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save1/Temp")
		
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save2")
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save2/Game")
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save2/RoomState")
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save2/Temp")
		
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save3")
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save3/Game")
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save3/RoomState")
		dir.make_dir(OS.get_user_data_dir() + "/Saves/Save3/Temp")
		
	if !dir.dir_exists(OS.get_user_data_dir() + "/Config"):
		dir.make_dir(OS.get_user_data_dir() + "/Config")