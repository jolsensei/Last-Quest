extends Node2D

var type = null
var damage = 2
var max_amount = 1
var has_counter = false

func _ready():
	_SFX.play_sfx("sword")
	type = get_parent().type
	$Animation.connect("animation_finished", self, "destroy")
	$Animation.play(str("sword_", get_parent().spriteMov))
	
	if get_parent().has_method("state_attack"):
		get_parent().current_state = _ENUMS.STATE.ATTACK
		
		
func destroy(animation):
	if get_parent().has_method("state_default"):
		get_parent().current_state = _ENUMS.STATE.DEFAULT
		
	queue_free()


func give_to_player():
	_GLOBAL_DATA.player.inventory[1] = load("res://Items/Goldy Blade/Goldy Blade.tscn")
	_SIGNAL_MANAGER.update_inventory()
	_SIGNAL_MANAGER.show(true, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("GOLDY_BLADE")))
