extends Node

var type = null
var damage = 0.25
var max_amount = 4

var speed = 120
var dirMov = null
var has_counter = false

func _ready():
	_SFX.play_sfx("arrow")
#	add_to_group("destroy_on_hit")
	type = get_parent().type
	dirMov = get_parent().last_dirMov
	self.position = get_parent().position
		
	var new_parent = get_parent().get_parent()
	get_parent().remove_child(self)
	new_parent.add_child(self)



func _process(delta):
	self.global_position += dirMov * speed * delta


func _on_HitBox_body_entered(body):
	if body.get("type") != _ENUMS.TYPE.PLAYER and body.get("type") != _ENUMS.TYPE.TERRAIN:
		_SFX.play_sfx("arrow_hit_wall")
		queue_free()