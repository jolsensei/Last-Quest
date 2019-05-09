extends Control

onready var save1 = $CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/TextureButton
onready var save2 = $CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/TextureButton2
onready var save3 = $CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/TextureButton3

onready var options = $CenterContainer/VBoxContainer/HBoxContainer2
onready var start = $CenterContainer/VBoxContainer/HBoxContainer2/TextureButton
onready var copy = $CenterContainer/VBoxContainer/HBoxContainer2/TextureButton2
onready var delete = $CenterContainer/VBoxContainer/HBoxContainer2/TextureButton3

var selected_file

func _ready():
	save1.grab_focus()
	
func _input(event):
	if Input.is_action_just_pressed("a") and save1.has_focus():
		start.grab_focus()
		options.visible = true
		selected_file = 1
		Input.action_release("a")
		
	if Input.is_action_just_pressed("b") and (start.has_focus() or copy.has_focus() or delete.has_focus()):
		save1.grab_focus()
		options.visible = false
	if Input.is_action_just_pressed("a") and start.has_focus():
		get_tree().change_scene("res://Engine/Game/Game.tscn")
#		get_tree().change_scene("res://Saves/Save"+selected_file+"/Game.tscn")