extends Node2D

enum LIST {NONE, GULL, GLARE, THORN, SPIRAK, POT, STONE}
export (LIST) var SPAWN_LIST


func spawn(to_spawn):
	
	var spawn
	
	match(to_spawn):
		LIST.GULL:
			spawn = load("res://Foes/Gull/gull.tscn").instance()
		LIST.GLARE:
			spawn = load("res://Foes/Glare/Glare.tscn").instance()
		LIST.SPIRAK:
			spawn = load("res://Foes/Spirak/Spirak.tscn").instance()
		LIST.THORN:
			spawn = load("res://Foes/Thorn-Thorn/Thorn-Thorn.tscn").instance()
	
	get_parent().add_child(spawn)
	spawn.global_transform = global_transform
	


func _on_Timer_timeout():
	if SPAWN_LIST != LIST.NONE:
		spawn(SPAWN_LIST)
