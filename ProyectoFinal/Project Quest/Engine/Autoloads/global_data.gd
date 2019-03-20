extends Node

var playerNode
var playerObject

var mapNode
var last_position

func _init():
	playerObject = Player.new("jolsensei")
	playerObject.set_item_A(Item.new("Sword", true, 1, 1, "res://Items/Sword/Iron Sword.tscn"))
	playerObject.set_item_B(Item.new("Boomerang", true, 1, 1, "res://Items/Sword/Iron Sword.tscn"))