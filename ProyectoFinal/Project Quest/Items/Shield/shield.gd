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
	_GLOBAL_DATA.player.inventory[4] = load("res://Items/Shield/Shield of Legend.tscn")
	_SIGNAL_MANAGER.update_inventory()
	_SIGNAL_MANAGER.show($Portrait.texture, ["You got the /*Legend's Shield*/! Wait, this is from an anime right?!","Use it with /*A*/ or /*B*/ to /*block*/ enemy attacks"])
