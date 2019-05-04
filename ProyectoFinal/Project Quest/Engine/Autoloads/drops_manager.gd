extends Node

var rupee = load("res://Drops/Rupees/1/Rupee.tscn")
var rupee_5 = load("res://Drops/Rupees/5/Rupee_5.tscn")
var heart = load("res://Drops/Hearts/Heart.tscn")
var key = load("res://Drops/Keys/Key.tscn")



func random_drop():
	
#	var random = randi() % 4 + 1
	var random = 10
	match random:
		1,3:
			return rupee.instance()
		2:
			return heart.instance()
		10:
			return rupee_5.instance()
