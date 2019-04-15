extends Node

var type = null
var damage = 1
var max_amount = 3

var speed = 150
var dirMov = null

func _ready():
	if get_parent().arrows > 0:
		add_to_group("destroy_on_hit")
		type = get_parent().type
		dirMov = get_parent().last_dirMov
		self.position = get_parent().position
		$Animation.play(get_parent().spriteMov)
		
		get_parent().arrows -= 1
		print(get_parent().arrows)
		
		var new_parent = get_parent().get_parent()
		get_parent().remove_child(self)
		new_parent.add_child(self)
	else:
		set_process(false)
		


func _process(delta):
	self.global_position += dirMov * speed * delta


func _on_HitBox_body_entered(body):
	if body.get("type") != _ENUMS.TYPE.PLAYER:
		queue_free()
