extends Node2D

enum LIST {NONE, GULL, GLARE, THORN, SPIRAK, POT, STONE, FAKE}
export (LIST) var SPAWN_LIST

enum DIRECTIONS {NONE, UP, DOWN, LEFT, RIGHT}

export (DIRECTIONS) var DIRECTION 

export var custom_speed = -1 #-1 means no value, not activated


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
			spawn.direction = DIRECTION
		LIST.POT:
			spawn = load("res://Events/Pot/Pot.tscn").instance()
		LIST.STONE:
			spawn = load("res://Events/Stone/Stone.tscn").instance()
		LIST.FAKE:
			spawn = load("res://Events/Fake block/FakeBlock.tscn").instance()
			
	if custom_speed != -1:
		spawn.global_speed = custom_speed
	
	spawn.z_index = -1
	get_parent().add_child(spawn)
	spawn.global_transform = global_transform
	


func _on_Timer_timeout():
	if SPAWN_LIST != LIST.NONE:
		spawn(SPAWN_LIST)
