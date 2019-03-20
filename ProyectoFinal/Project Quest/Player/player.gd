extends Object


class_name Player

#Ingame visible data
var name:String
var max_hearts:float
var hearts:float
var max_rupees:int
var rupees:int

var item_A:Item
var item_B:Item

#Ingame invisible data

var speed:int
var hitStun:int

func _init(start_name:String):
	name = start_name
	max_hearts = 3.0
	hearts = 1.75
	max_rupees = 99
	rupees = 0
	
	speed = 60
	
	
func damage(damage_suffered:float):
	hearts -= damage_suffered

func add_rupees(earned_rupees:int):
	rupees += earned_rupees
	
func get_item_A():
	return item_A
	
func set_item_A(item):
	self.item_A = item
	
func get_item_B():
	return item_B
	
func set_item_B(item):
	self.item_B = item

