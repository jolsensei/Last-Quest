extends Control

var caps_activated = false

func _ready():
	$Keyboard/A.grab_focus()
	translate()
	
func _input(event):
	if  Input.is_action_just_pressed("a") and (!$Caps.has_focus() and !$End.has_focus()):
		var char_selected = get_focus_owner()
		add_to_name(char_selected.get_node("Label").text)
		_SFX.play_sfx("cursor")
	if Input.is_action_just_pressed("b"):
		delete_last()
	if Input.is_action_just_pressed("a") and $Caps.has_focus():
		to_caps()
	if Input.is_action_just_pressed("a") and $End.has_focus():
		start_game()
		
func add_to_name(character):
	
	if caps_activated:
		$Name.text = $Name.text + character.to_upper()
	else:
		$Name.text = $Name.text + character

func delete_last():
	
	if $Name.text == "":
		get_tree().change_scene("res://Engine/Menus/Files/Files.tscn")
	
	var size = $Name.text.length()
	var text = $Name.text
	$Name.text = $Name.text.substr(0, size-1)
	
	
	
func to_caps():
	
	caps_activated = not caps_activated
	
	for character in $Keyboard.get_children():
		character.get_node("Label").uppercase = caps_activated
		
	for character in $Keyboard2.get_children():
		character.get_node("Label").uppercase = caps_activated
		
	for character in $Keyboard3.get_children():
		character.get_node("Label").uppercase = caps_activated
		
func start_game():
	_GLOBAL_DATA.player_name = $Name.text
	get_tree().change_scene("res://Engine/Game/Game.tscn")
	
func translate():
	$Label.text = tr("T_CHOOSE_NAME")
	$Caps/Label.text = tr("T_CAPS")
	$End/Label.text = tr("T_END")
