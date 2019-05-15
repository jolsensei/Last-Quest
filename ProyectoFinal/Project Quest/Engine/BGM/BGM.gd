extends Control

var title = load("res://Engine/BGM/BGMDB/Dunes at Night.wav")
var files = load("res://Engine/BGM/BGMDB/Blueberry March.wav")

func play_bgm(track):
	 
	$AudioStreamPlayer.set_volume_db(_GLOBAL_DATA.bgm_volume)
	$AudioStreamPlayer.set_stream(get(track))
	$AudioStreamPlayer.play()
	
func stop_bgm():
	$AudioStreamPlayer.stop()
	
func change_volume_db(db):
	$AudioStreamPlayer.set_volume_db(db)