extends Node

var rupee = load("res://Drops/Rupees/Rupee.tscn")
var heart = load("res://Drops/Hearts/Heart.tscn")



func random_drop():
	
	var random = randi() % 4 + 1
	match random:
		1:
			return rupee.instance()
		2:
			return heart.instance()
