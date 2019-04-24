extends CanvasLayer

var saved_warp_to
var saved_warp_position

func _ready():
	_SIGNAL_MANAGER.connect("enter_animation", self, "enter_animation") 


func enter_animation(warp_to, warp_position, zone_name):
	get_tree().paused = true
	$Animation.play("enter")
	saved_warp_to = warp_to
	saved_warp_position = warp_position
	if zone_name != null:
		$Label.text = zone_name
	
func _on_Animation_animation_finished(anim_name):
	if anim_name == "enter":
		$Animation.play("exit")
		_CURRENT_MAP.changeLevel(saved_warp_to, saved_warp_position)
		$LabelAnimation.play("show_zone_name")
		
	if anim_name != "show_zone_name":
		get_tree().paused = false
