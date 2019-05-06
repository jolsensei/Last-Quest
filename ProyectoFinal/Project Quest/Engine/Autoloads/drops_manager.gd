extends Node

var rupee = load("res://Drops/Rupees/1/Rupee.tscn")
var rupee_5 = load("res://Drops/Rupees/5/Rupee_5.tscn")
var heart = load("res://Drops/Hearts/Heart.tscn")
var key = load("res://Drops/Keys/Key.tscn")
var arrows = load("res://Drops/Arrows/Arrow.tscn")
var bombs = load("res://Drops/Bombs/Bombs.tscn")



func random_drop():
	
	var random = randi() % 9 + 1
#	var random = 10
	match random:
		1,3,7,9:
			return rupee.instance()
		2,4:
			return heart.instance()
		6:
			return arrows.instance()
		8:
			return bombs.instance()
		5,10:
			return rupee_5.instance()
