extends Node

var arrow_hit_wall = load("res://Engine/SFX/SoundsDB/arrow hit wall.wav")
var arrow = load("res://Engine/SFX/SoundsDB/arrow.wav")
var bomb_explode = load("res://Engine/SFX/SoundsDB/bomb explode.wav")
var boomerang = load("res://Engine/SFX/SoundsDB/boomerang.wav")
var break_sound = load("res://Engine/SFX/SoundsDB/break.wav")
var chest_appears = load("res://Engine/SFX/SoundsDB/chest appears.wav")
var chest_open = load("res://Engine/SFX/SoundsDB/chest open.wav")
var cursor = load("res://Engine/SFX/SoundsDB/cursor.wav")
var door_open = load("res://Engine/SFX/SoundsDB/door open.wav")
var enemy_hit = load("res://Engine/SFX/SoundsDB/enemy hit.wav")
var enemy_dies = load("res://Engine/SFX/SoundsDB/enemy dies.wav")
var grass_destroyed = load("res://Engine/SFX/SoundsDB/grass destroyed.wav")
var heart_container = load("res://Engine/SFX/SoundsDB/heart container.wav")
var heart_piece = load("res://Engine/SFX/SoundsDB/heart piece.wav")
var heart = load("res://Engine/SFX/SoundsDB/heart.wav")
var item_get = load("res://Engine/SFX/SoundsDB/item get.wav")
var key = load("res://Engine/SFX/SoundsDB/key.wav")
var land = load("res://Engine/SFX/SoundsDB/land.wav")
var lay_bomb = load("res://Engine/SFX/SoundsDB/lay bomb.wav")
var lift = load("res://Engine/SFX/SoundsDB/lift.wav")
var link_dies = load("res://Engine/SFX/SoundsDB/link dies.wav")
var link_falls = load("res://Engine/SFX/SoundsDB/link falls.wav")
var link_hurt = load("res://Engine/SFX/SoundsDB/link hurt.wav")
var low_hp = load("res://Engine/SFX/SoundsDB/low hp.wav")
var map = load("res://Engine/SFX/SoundsDB/map.wav")
var menu_close = load("res://Engine/SFX/SoundsDB/menu close.wav")
var menu_open = load("res://Engine/SFX/SoundsDB/menu open.wav")
var message_finish = load("res://Engine/SFX/SoundsDB/message finish.wav")
var message = load("res://Engine/SFX/SoundsDB/message.wav")
var rupee = load("res://Engine/SFX/SoundsDB/rupee.wav")
var secret = load("res://Engine/SFX/SoundsDB/secret.wav")
var sword = load("res://Engine/SFX/SoundsDB/sword.wav")
var throw = load("res://Engine/SFX/SoundsDB/throw.wav")
var use_key = load("res://Engine/SFX/SoundsDB/use key.wav")




func _ready():
	_SIGNAL_MANAGER.connect("play_sfx", self, "play_sfx")

#func play_sfx(sound):
#	set_stream(get(sound))
#	play()
	
func play_sfx(sound):
	var sfx = AudioStreamPlayer.new()
	sfx.pause_mode = Node.PAUSE_MODE_PROCESS
	sfx.set_volume_db(-20)
	sfx.set_stream(get(sound))
	add_child(sfx)
	sfx.play()
	