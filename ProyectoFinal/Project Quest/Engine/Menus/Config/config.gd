extends Control

onready var BGM = $BGMSlider
onready var SFX = $SFXSlider
onready var spanish = $Spanish
onready var english = $English

var go_back
var spanish_selected
var english_selected

func _ready():
	translate()
	set_actual_config()
	BGM.grab_focus()
	
func _input(event):
	get_input_event()
	
	match(true):
		go_back:
			get_tree().change_scene("res://Engine/Menus/Files/Files.tscn")
			_SAVE_SYSTEM.save_config()
		spanish_selected:
			change_language("es")
			translate()
		english_selected:
			change_language("en")
			translate()


func get_input_event():
	go_back = Input.is_action_just_pressed("b")
	spanish_selected = Input.is_action_just_pressed("a") and spanish.has_focus()
	english_selected = Input.is_action_just_pressed("a") and english.has_focus()

func _on_BGMSlider_value_changed(value):
	_GLOBAL_DATA.bgm_volume = parse_volume_to_db(value)
	
func _on_SFXSlider_value_changed(value):
	_GLOBAL_DATA.sfx_volume = parse_volume_to_db(value)
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		_SFX.play_sfx("rupee")
	
func parse_volume_to_db(number):
	var db = -50
	
	match(str(number)): #For some reason this does not work with numbers, so it's parsed to string
		'0':
			db = -100
		'1':
			db = -90
		'2':
			db = -80
		'3':
			db = -70
		'4':
			db = -60
		'5':
			db = -50
		'6':
			db = -40
		'7':
			db = -30
		'8':
			db = -20
		'9':
			db = -10
		'10':
			db = 0
	return db
	
func parse_db_to_volume(db):
	var volume = 5
	
	match(str(db)):
		'-100':
			volume = 0
		'-90':
			volume = 1
		'-80':
			volume = 2
		'-70':
			volume = 3
		'-60':
			volume = 4
		'-50':
			volume = 5
		'-40':
			volume = 6
		'-30':
			volume = 7
		'-20':
			volume = 8
		'-10':
			volume = 9
		'0':
			volume = 10
	return volume
	
func set_actual_config():
	SFX.value = parse_db_to_volume(_GLOBAL_DATA.sfx_volume)
	BGM.value = parse_db_to_volume(_GLOBAL_DATA.bgm_volume)
	
func change_language(lang):
	_GLOBAL_DATA.locale = lang
	TranslationServer.set_locale(lang)
	
func translate():
	$Config.text = tr("T_CONFIG_MESSAGE")
	$Language.text = tr("T_LANG")
	$Spanish/Label.text = tr("T_SPANISH")
	$English/Label.text = tr("T_ENGLISH")
