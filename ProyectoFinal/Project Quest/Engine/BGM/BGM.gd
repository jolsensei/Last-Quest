extends Control

var title = load("res://Engine/BGM/BGMDB/Dunes at Night.wav")
var files = load("res://Engine/BGM/BGMDB/Blueberry March.wav")
var game_over = load("res://Engine/BGM/BGMDB/At the End of the Day.wav")
var overworld = load("res://Engine/BGM/BGMDB/On Our Way.wav")
var town = load("res://Engine/BGM/BGMDB/Seaside Town.wav")
var beach = load("res://Engine/BGM/BGMDB/Middle Park.wav")
var credits = load("res://Engine/BGM/BGMDB/Getting Started.wav")
var caves = load("res://Engine/BGM/BGMDB/Here Comes the 8-bit Empire.wav")
var mountain = load("res://Engine/BGM/BGMDB/Facehammer.wav")

func play_bgm(track):
	 
	$AudioStreamPlayer.set_volume_db(_GLOBAL_DATA.bgm_volume)
	$AudioStreamPlayer.set_stream(get(track))
	$AudioStreamPlayer.play()
	
func stop_bgm():
	$AudioStreamPlayer.stop()
	
func change_volume_db(db):
	$AudioStreamPlayer.set_volume_db(db)

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()
