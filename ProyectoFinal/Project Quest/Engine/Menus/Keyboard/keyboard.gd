extends Control

var caps_activated = false

var on_key
var on_back
var on_caps
var on_end

func _ready():
	$Keyboard/A.grab_focus()
	translate()
	
func _input(event):
	get_input_event()
	
	match(true):
		on_key:
			var char_selected = get_focus_owner()
			add_to_name(char_selected.get_node("Label").text)
			_SFX.play_sfx("cursor")
		on_back:
			delete_last()
		on_caps:
			to_caps()
		on_end:
			start_game()

func get_input_event():
	on_key = Input.is_action_just_pressed("a") and (!$Caps.has_focus() and !$End.has_focus())
	on_back = Input.is_action_just_pressed("b")
	on_caps = Input.is_action_just_pressed("a") and $Caps.has_focus()
	on_end = Input.is_action_just_pressed("a") and $End.has_focus()

func add_to_name(character):
	if $Name.text.length() < 14:
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
