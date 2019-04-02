extends Node

func play(sound):
	var loaded_sound = load("res://Engine/SFX/SoundsDB/"+sound+".wav")
#	var sfx = AudioStreamPlayer.new()
#	get_tree().get_root().add_child(sfx)
#	sfx.set_stream(loaded_sound)
#	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), _GLOBAL_DATA.volume)
#	sfx.volume_db = _GLOBAL_DATA.volume
#	sfx.set_volumedb(_GLOBAL_DATA.volume)
#	sfx.connect("finished", sfx, "queue_free")
#	sfx.play()

	$Player.set_stream(loaded_sound)
#	$Player.connect("finished", self, "queue_free")
	$Player.play()