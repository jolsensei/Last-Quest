extends Control

onready var saves = $Saves
onready var save1 = $Saves/File1
onready var save2 = $Saves/File2
onready var save3 = $Saves/File3

onready var options = $Options
onready var start = $Options/Start
onready var copy = $Options/Clone
onready var delete = $Options/Delete

var hover_save1
var hover_save2
var hover_save3 

func _ready():
	save1.grab_focus()
	
	refresh_focus()
	
func _input(event):
	refresh_focus()
	get_file_data()
	
	if Input.is_action_just_pressed("a") and (save1.has_focus() or save2.has_focus() or save3.has_focus()):
		start.grab_focus()
		change_visibility()
		Input.action_release("a")
		
	if Input.is_action_just_pressed("b") and (start.has_focus() or copy.has_focus() or delete.has_focus()):
		save1.grab_focus()
		change_visibility()
	if Input.is_action_just_pressed("a") and start.has_focus():
		start_game()

func change_visibility():
	saves.visible = not saves.visible
	options.visible = not options.visible
	
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
	var has_data = Directory.new().file_exists("res://Saves/Save"+str(number)+"/Game/Player.tscn")

	if has_data:
		show_file_data(number)
		$NoData.visible = false
		$FileData.visible = true
	else:
		$NoData.visible = true
		$FileData.visible = false
		
	
func refresh_focus():
	hover_save1 = save1.has_focus()
	hover_save2 = save2.has_focus()
	hover_save3 = save3.has_focus()
	
func show_file_data(number):
	var data = load("res://Saves/Save"+str(number)+"/Game/Player.tscn").instance()
	$FileData/FileHeartsN.text = str(data.max_hearts)
	$FileData/FileRupeesN.text = str(data.rupees)
	$FileData/Name.text = data.player_name
	$FileData/HeartPieces.frame = data.heart_pieces

func start_game():
	get_tree().change_scene("res://Engine/Game/Game.tscn")