extends Node

var type = null
var damage = 1
var max_amount = 1

var speed = 150
var dirMov = null
var has_counter = true

func _ready():
	if get_parent().arrows > 0:
		_SFX.play_sfx("arrow")
		add_to_group("destroy_on_hit")
		type = get_parent().type
		dirMov = get_parent().last_dirMov
		self.position = get_parent().position
		$Animation.play(get_parent().spriteMov)
		get_parent().arrows -= 1
		_SIGNAL_MANAGER.update_counter(get_parent().arrows, self.name)
		print(get_parent().arrows)
		
		var new_parent = get_parent().get_parent()
		get_parent().remove_child(self)
		new_parent.add_child(self)
	else:
		queue_free()
		


func _process(delta):
	self.global_position += dirMov * speed * delta


func _on_HitBox_body_entered(body):
	if body.get("type") != _ENUMS.TYPE.PLAYER and body.get("type") != _ENUMS.TYPE.TERRAIN:
		_SFX.play_sfx("arrow_hit_wall")
		queue_free()

