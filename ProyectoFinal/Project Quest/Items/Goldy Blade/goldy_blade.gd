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

func _on_Animation_animation_finished(anim_name):
	match(anim_name):
		"sword_left":
			$Animation.play("left_up")
