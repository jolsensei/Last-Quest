extends CanvasLayer

var visbility

func _ready():
	_SIGNAL_MANAGER.connect("show_keys", self, "show_keys") 

func _on_Player_key_picked():
	$Label.set_text(str(_GLOBAL_DATA.player.keys))
	
func show_keys(boolean):
	$Timer.start()
	visbility = boolean

func _on_Timer_timeout():
	$Sprite.visible = visbility
	$Label.visible = visbility
