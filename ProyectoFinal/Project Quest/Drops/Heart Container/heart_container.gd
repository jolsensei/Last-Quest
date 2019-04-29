extends "res://Drops/drop.gd"

var ready_to_free = false

func _ready():
	_SIGNAL_MANAGER.connect("dialog_finished", self, "dialog_finished")

func body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		_SFX.play_sfx("heart_container")
		body.global_max_hearts += 1
		body.global_hearts = body.global_max_hearts
		_SIGNAL_MANAGER.update_hearts()
		show_text()
		body.can_interact = true
		ready_to_free = true

func give_to_player():
	_SFX.play_sfx("heart_container")
	_GLOBAL_DATA.player.global_max_hearts += 1
	_GLOBAL_DATA.player.global_hearts = _GLOBAL_DATA.player.global_max_hearts
	_SIGNAL_MANAGER.update_hearts()
	show_text()

func show_text():
	_SIGNAL_MANAGER.show(false, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("HEART_CONTAINER")))
	
func dialog_finished():
	if ready_to_free:
		_GLOBAL_DATA.player.can_interact = false
		queue_free()