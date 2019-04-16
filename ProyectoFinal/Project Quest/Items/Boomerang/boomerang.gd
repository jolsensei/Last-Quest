extends Node

var type = null
var damage = 0
var max_amount = 1
var has_counter = false

var speed = 150
var dirMov = null

func _ready():
	type = get_parent().type
	dirMov = get_parent().dirMov
	self.position = get_parent().position
	
	var new_parent = get_parent().get_parent()
	get_parent().remove_child(self)
	new_parent.add_child(self)


func _process(delta):
	self.global_position += dirMov * speed * delta
