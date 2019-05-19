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
	_BGM.change_volume_db(_GLOBAL_DATA.bgm_volume)
	
func _on_SFXSlider_value_changed(value):
	_GLOBAL_DATA.sfx_volume = parse_volume_to_db(value)
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		_SFX.play_sfx("rupee")
	
func parse_volume_to_db(number):
	var db = -50
	
	match(str(number)): #For some reason this does not work with numbers, so it's parsed to string
		'0':
			db = -80
		'1':
			db = -74
		'2':
			db = -68
		'3':
			db = -62
		'4':
			db = -56
		'5':
			db = -50
		'6':
			db = -44
		'7':
			db = -38
		'8':
			db = -32
		'9':
			db = -26
		'10':
			db = -20
	return db
	
func parse_db_to_volume(db):
	var volume = 5
	
	match(str(db)):
		'-80':
			volume = 0
		'-74':
			volume = 1
		'-68':
			volume = 2
		'-62':
			volume = 3
		'-56':
			volume = 4
		'-50':
			volume = 5
		'-44':
			volume = 6
		'-38':
			volume = 7
		'-32':
			volume = 8
		'-26':
			volume = 9
		'-20':
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
