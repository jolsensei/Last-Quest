extends Node

var type = null
var damage = 1
var max_amount = 1

var speed = 150
var dirMov = null
var has_counter = true

func _ready():
	if get_parent().arrows > 0 and get_tree().get_nodes_in_group("destroy_on_hit").size() < max_amount:
		_SFX.play_sfx("arrow")
		add_to_group("destroy_on_hit")
		type = get_parent().type
		dirMov = get_parent().last_dirMov
		self.position = get_parent().position
		$Animation.play(get_parent().spriteMov)
		get_parent().arrows -= 1
		_SIGNAL_MANAGER.update_counter(get_parent().arrows, self.name)
#		print(get_parent().arrows)
		$Timer.start()
		
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
		
func give_to_player():
	_GLOBAL_DATA.player.inventory[6] = load("res://Items/Bow/Bow.tscn")
	_SIGNAL_MANAGER.update_inventory()
	_SIGNAL_MANAGER.show(true, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("BOW")))


func _on_Timer_timeout():
	queue_free()
