extends Node

var type = null
var damage = 0
var max_amount = 1

var speed = 120
var dirMov = null
var has_counter = false

var going_back = false

func _ready():
	$Timer.start()
	type = get_parent().type
	dirMov = get_parent().last_dirMov
	self.position = get_parent().position
	$Animation.play("spin")
	var new_parent = get_parent().get_parent()
	get_parent().remove_child(self)
	new_parent.add_child(self)


func _process(delta):
	if going_back:
		self.global_position -= dirMov * speed * delta
	else:
		self.global_position += dirMov * speed * delta



func _on_HitBox_body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and going_back:
		queue_free()
	elif body.get("type") != _ENUMS.TYPE.PLAYER:
		going_back = not going_back


func _on_Timer_timeout():
	$Timer.stop()
	going_back = true
