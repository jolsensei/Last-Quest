extends Object

class_name Item

var name:String
var can_set:bool
var max_quantity:int
var damage:int

var scene

func _init(item_name:String, can_set:bool, max_quantity:int, damage:int, scene:String):
	self.name = item_name
	self.can_set = can_set
	self.max_quantity = max_quantity
	self.damage = damage 
	
	self.scene = load(scene)

	

