extends Control

var arrows
var yes
var no

func _ready():
	translate()
	_BGM.play_bgm("game_over")
	$Yes.grab_focus()
	
func _input(event):
	update_events()
	
	match(true):
		arrows:
			_SFX.play_sfx("cursor")
		yes:
			get_tree().change_scene("res://Engine/Game/Game.tscn")
		no:
			get_tree().change_scene("res://Engine/Menus/Title/Title.tscn")
			
		
func update_events():
	arrows = Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")
	yes = Input.is_action_pressed("a") and $Yes.has_focus()
	no = Input.is_action_pressed("a") and $No.has_focus()
	
func translate():
	$Yes/Label.text = tr("T_YES")
	$No/Label.text = tr("T_NO")
	$Continue.text = tr("T_CONTINUE")
	
	
