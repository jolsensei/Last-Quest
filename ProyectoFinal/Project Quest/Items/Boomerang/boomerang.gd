extends KinematicBody2D

var type = null
var damage = 0
var max_amount = 1

var speed = 120
var dirMov = null
var has_counter = false

var going_back = false
var body_exited = false

var item = null
var carry_item = false

func _ready():
	$Timer.start()
	$SFX.start()
	type = get_parent().type
	dirMov = get_parent().last_dirMov
	self.position = get_parent().position
	$Animation.play("spin")
	var new_parent = get_parent().get_parent()
	get_parent().remove_child(self)
	new_parent.add_child(self)


func _process(delta):
	if going_back:
		var direction = (_GLOBAL_DATA.player.global_position - self.global_position).normalized()
		move_and_slide(direction*speed)
		if carry_item and item.get_ref():
			item.get_ref().global_position = self.global_position

	else:
		self.global_position += dirMov * speed * delta
		
		
func _on_HitBox_body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER and going_back:
		queue_free()
		carry_item = false

	elif body.get("type") != _ENUMS.TYPE.PLAYER and body.get("type") != _ENUMS.TYPE.TERRAIN:
		going_back = true
		if !body_exited:
			queue_free()
		
func _on_HitBox_body_exited(body): #In order to solve a bug, whe need to know if the boomerang left the player
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		body_exited = true

func _on_Timer_timeout():
	$Timer.stop()
	going_back = true


func _on_HitBox_area_entered(area):
	if area.has_method("give_to_player"):
		going_back = true
		item = weakref(area)
		carry_item = true
		if !body_exited:
			queue_free()

func _on_SFX_timeout():
	_SFX.play_sfx("boomerang")
	
func give_to_player():
	_GLOBAL_DATA.player.inventory[5] = load("res://Items/Boomerang/Boomerang.tscn")
	_SIGNAL_MANAGER.update_inventory()
	_SIGNAL_MANAGER.show(true, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("BOOMERANG")))
