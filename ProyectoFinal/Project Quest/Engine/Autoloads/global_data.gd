extends Node

var slot = 2
var player
var player_name
var map
var world = []
var last_position
var last_map = 0
var bgm_volume = -50
var sfx_volume = -50
var locale = "en"

func _init():
	world.resize(3)
	world[0] = load("res://Maps/TestRoom.tscn")
	world[1] = load("res://Maps/TestRoom_2.tscn")
	world[2] = load("res://Maps/TestRoom_3.tscn")