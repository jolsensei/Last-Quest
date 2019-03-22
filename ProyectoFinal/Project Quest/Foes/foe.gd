extends Object

class_name Foe

var name:String
var damage:int
var hearts:float
var drop:Item

var scene

func _init(name:String, damage:int, hearts:float, drop:Item, scene:String):
	
	self.name = name
	self.damage = damage
	self.hearts = hearts
	self.drop = drop 
	
	self.scene = load(scene)

