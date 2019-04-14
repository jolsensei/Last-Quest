extends Node

var rupee = load("res://Drops/Rupees/Rupee.tscn")
var heart = load("res://Drops/Hearts/Heart.tscn")



func random_drop():
	
	var random = randi() % 4 + 1
#	var random = 2
	match random:
		1,3:
			return rupee.instance()
		2:
			return heart.instance()
