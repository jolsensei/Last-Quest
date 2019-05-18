extends Control

onready var saves = $Saves
onready var save1 = $Saves/File1
onready var save2 = $Saves/File2
onready var save3 = $Saves/File3
onready var config = $Config

onready var options = $Options
onready var start = $Options/Start
onready var copy = $Options/Clone
onready var delete = $Options/Delete

onready var yesno = $YesNo
onready var yes = $YesNo/Yes
onready var no = $YesNo/No

var hover_save1
var hover_save2
var hover_save3 

var select_file
var go_back
var start_game
var sure_to_delete
var cancel_delete
var delete_file
var config_select
var go_to_title
var clone_pressed
var cancel_cloning
var on_clone_confirmation
var on_cancel_cloning_confirmation
var on_clone

var has_data
var cloning = false
var file_to_clone


func _ready():
	translate()
	save1.grab_focus()
	refresh_focus()
	check_file_data(_GLOBAL_DATA.slot)
	
func _input(event):
	refresh_focus()
	get_file_data()
	get_input_event()
	
	match(true):
		select_file:
			start.grab_focus()
			change_visibility()
			_SFX.play_sfx("cursor")
			Input.action_release("a")
		go_back:
			save1.grab_focus()
			_SFX.play_sfx("cursor")
			change_visibility()
		start_game:
			play_game()
		sure_to_delete:
			are_sure_to_delete()
			_SFX.play_sfx("cursor")
			Input.action_release("a")
		cancel_delete:
			cancel_delete_option()
			_SFX.play_sfx("cursor")
		delete_file:
			_SFX.play_sfx("cursor")
			print(_GLOBAL_DATA.slot)
			_SAVE_SYSTEM.delete_data(_GLOBAL_DATA.slot)
			cancel_delete_option()
			check_file_data(_GLOBAL_DATA.slot)
#			_GLOBAL_DATA.slot = 1
		config_select:
			_SFX.play_sfx("cursor")
			go_to_config()
		go_to_title:
			get_tree().change_scene("res://Engine/Menus/Title/Title.tscn")
		clone_pressed:
			start_clone()
		cancel_cloning:
			cancel_clone()
		on_clone_confirmation:
			clone_confirmation()
		on_cancel_cloning_confirmation:
			cancel_cloning_confirmation()
		on_clone:
			print("Clone")
			clone()
		
func get_input_event():
	select_file = Input.is_action_just_pressed("a") and (save1.has_focus() or save2.has_focus() or save3.has_focus()) and !cloning
	go_back = Input.is_action_just_pressed("b") and (start.has_focus() or copy.has_focus() or delete.has_focus())
	start_game = Input.is_action_just_pressed("a") and start.has_focus()
	sure_to_delete = Input.is_action_just_pressed("a") and delete.has_focus()
	cancel_delete = (Input.is_action_just_pressed("b") and (yes.has_focus() or no.has_focus())) or (Input.is_action_just_pressed("a") and no.has_focus()) and !cloning
	delete_file = Input.is_action_just_pressed("a") and yes.has_focus() and !cloning
	config_select = Input.is_action_just_pressed("a") and config.has_focus()
	go_to_title = Input.is_action_just_pressed("b") and !cloning
	clone_pressed = Input.is_action_just_pressed("a") and copy.has_focus()
	cancel_cloning = Input.is_action_just_pressed("b") and (save1.has_focus() or save2.has_focus() or save3.has_focus()) and cloning
	on_clone_confirmation = Input.is_action_just_pressed("a") and (save1.has_focus() or save2.has_focus() or save3.has_focus()) and cloning
	on_cancel_cloning_confirmation = (Input.is_action_just_pressed("b") and (yes.has_focus() or no.has_focus())) or (Input.is_action_just_pressed("a") and no.has_focus()) and cloning
	on_clone = Input.is_action_just_pressed("a") and yes.has_focus() and cloning

func change_visibility():
	saves.visible = not saves.visible
	options.visible = not options.visible
	$Config.visible =  not $Config.visible
	
func are_sure_to_delete():
	yesno.visible = true
	options.visible = false
	no.grab_focus()
	$Label.text = tr("T_CONFIRMATION")

func cancel_delete_option():
	yesno.visible = false
	options.visible = true
	start.grab_focus()
	$Label.text = tr("T_MESSAGE")
	
	
func get_file_data():
	match(true):
		hover_save1:
			check_file_data(1)
			_GLOBAL_DATA.slot = 1
		hover_save2:
			check_file_data(2)
			_GLOBAL_DATA.slot = 2
		hover_save3:
			check_file_data(3)
			_GLOBAL_DATA.slot = 3


func check_file_data(number):
	has_data = Directory.new().file_exists("user://Saves/Save"+str(number)+"/Game/Player.tscn")

	if has_data:
		show_file_data(number)
		$NoData.visible = false
		$FileData.visible = true
		$Sprite.visible = true
	else:
		$NoData.visible = true
		$FileData.visible = false
		$Sprite.visible = false
		
	
func refresh_focus():
	hover_save1 = save1.has_focus()
	hover_save2 = save2.has_focus()
	hover_save3 = save3.has_focus()
	
func show_file_data(number):
	var data = load("user://Saves/Save"+str(number)+"/Game/Player.tscn").instance()
	generate_hearts(data)
	$FileData/FileRupeesN.text = str(data.rupees)
	$FileData/Name.text = data.player_name
	$FileData/HeartPieces.frame = data.heart_pieces

func play_game():
	if has_data:
		get_tree().change_scene("res://Engine/Game/Game.tscn")
	else:
		get_tree().change_scene("res://Engine/Menus/Keyboard/Keyboard.tscn")
	
func go_to_config():
	get_tree().change_scene("res://Engine/Menus/Config/Config.tscn")
	
func start_clone():
	cloning = true
	file_to_clone = _GLOBAL_DATA.slot
			
	$Label.text = tr("T_CLONING")
	change_visibility()
	$Config.visible = false
	save1.grab_focus()
	
func cancel_clone():
	cloning = false
	
	$Label.text = tr("T_MESSAGE")
	change_visibility()
	$Config.visible = false
	copy.grab_focus()
	
func clone_confirmation():
	yesno.visible = true
	options.visible = false
	saves.visible = false
	no.grab_focus()
	$Label.text = tr("T_CONFIRMATION")
	
func cancel_cloning_confirmation():
	cloning = false
	yesno.visible = false
	options.visible = true
	copy.grab_focus()
	$Label.text = tr("T_MESSAGE")
	
func clone():
	cloning = false
	_SAVE_SYSTEM.clone(file_to_clone, _GLOBAL_DATA.slot)
	yesno.visible = false
	options.visible = false
	saves.visible = true
	config.visible = true
	$Label.text = tr("T_MESSAGE")
	save1.grab_focus()

func generate_hearts(data):
	
	
	for child in  $FileData/FileHearts.get_children(): #We delete them as we are going to create new ones
		 $FileData/FileHearts.remove_child(child)
	
	for i in data.max_hearts:
		var new_heart = Sprite.new()
		new_heart.texture = $FileData/FileHearts.texture
		new_heart.hframes = $FileData/FileHearts.hframes
		$FileData/FileHearts.add_child(new_heart)
		
	for heart in $FileData/FileHearts.get_children():
		var index = heart.get_index()

		var x = (index % 6) * 10
		var y = (index / 6) * 10
		heart.position = Vector2(x,y)

		var last_heart = floor(data.hearts)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (data.hearts - last_heart) * 4
		if index < last_heart:
			heart.frame = 4


func translate():
	$Saves/File1/Label.text = tr("T_FILE_1")
	$Saves/File2/Label2.text = tr("T_FILE_2")
	$Saves/File3/Label3.text = tr("T_FILE_3")
	$Config/Label3.text = tr("T_CONFIG")
	
	$Label.text = tr("T_MESSAGE")
	$NoData.text = tr("T_NO_DATA")
	
	$Options/Start/Label4.text = tr("T_START")
	$Options/Clone/Label5.text = tr("T_CLONE")
	$Options/Delete/Label6.text = tr("T_DELETE")
	
	$YesNo/Yes/Label4.text = tr("T_YES")
	$YesNo/No/Label4.text = tr("T_NO")
	
