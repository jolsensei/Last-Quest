extends Control

var globalDialog
var page = 0
var currently_in_dialog = false

func _ready():
	_SIGNAL_MANAGER.connect("send_dialog", self, "print_dialog")
	$Container/Label.set_visible_characters(0)
	set_process_input(false)
	

func print_dialog(texture, dialog):
	
	dialog = highlight(dialog, Color.red)
	
	if texture != null:
		put_texture(true, texture)
	else:
		put_texture(false, null)
	
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
				_GLOBAL_DATA.player.get_node("GetItem").texture = null #In the case we recieved an item
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

func put_texture(boolean, texture):
	if boolean:
		$Container/Portrait.texture = texture
		$Container/Label.margin_left = 32
	else:
		$Container/Portrait.texture = null
		$Container/Label.margin_left = 6
		

func highlight(dialog, color):
	var highlighted_dialog = []
	highlighted_dialog.resize(dialog.size())
	var count = 0
	for text in dialog:
		text = text.replace("/*", "[color=red]")
		text = text.replace("*/", "[/color]")
		highlighted_dialog[count] = text
		count += 1

	return highlighted_dialog
	
