extends Control

var globalDialog
var page = 0
var currently_in_dialog = false

func _ready():
	_DIALOG_MANAGER.connect("send_dialog", self, "print_dialog")
	$Container/Label.set_visible_characters(0)
	set_process_input(false)
	

func print_dialog(dialog):
	
	globalDialog = dialog
	
	$Container/Label.set_bbcode(globalDialog[page])
	
	$Timer.start()
	
	on_dialog(true)
	
	
	
	
	

func _input(event):
	if Input.is_action_just_pressed("a") and currently_in_dialog:
		if $Container/Label.get_visible_characters() > $Container/Label.get_total_character_count():
			if page < globalDialog.size()-1:
				page += 1
				$Container/Label.set_bbcode(globalDialog[page])
				$Container/Label.set_visible_characters(0)
			else:
				Input.action_release("a")
				on_dialog(false)
		else:
			$Container/Label.set_visible_characters($Container/Label.get_total_character_count())


func _on_Timer_timeout():
	$Container/Label.set_visible_characters($Container/Label.get_visible_characters()+1)
	
func on_dialog(boolean):
	
	currently_in_dialog = boolean
	set_process_input(boolean)
	get_tree().paused = boolean
	visible = boolean
	
	if !boolean:
		$Container/Label.set_visible_characters(0)
		$Timer.stop()
		page = 0

