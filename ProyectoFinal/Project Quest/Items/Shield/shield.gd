extends Node2D

var type = null
var damage = 0
var max_amount = 1
var has_counter = false


func _ready():
	type = get_parent().type
	$Animation.connect("animation_finished", self, "destroy")
	$Animation.play(str("shield_", get_parent().spriteMov))
	
	if get_parent().has_method("state_attack"):
		get_parent().current_state = _ENUMS.STATE.ATTACK
		
		
func destroy(animation):
	if get_parent().has_method("state_default"):
		get_parent().current_state = _ENUMS.STATE.DEFAULT

	queue_free()

func give_to_player():
	_GLOBAL_DATA.player.inventory[3] = load("res://Items/Shield/Shield of Legend.tscn")
	_SIGNAL_MANAGER.update_inventory()
	_SIGNAL_MANAGER.show(true, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("LEGENDS_SHIELD")))


func _on_HitBox_body_entered(body):
	if body.is_in_group("shield"):
		body.speed = body.speed * -1
		_SFX.play_sfx("arrow_hit_wall")


func _on_HitBox_area_entered(area):
	if area.get_parent().is_in_group("destroy_on_hit"):
		area.get_parent().speed = area.get_parent().speed * -1
		area.get_parent().type = type
		_SFX.play_sfx("arrow_hit_wall")
