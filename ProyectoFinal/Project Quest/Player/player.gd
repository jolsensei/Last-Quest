extends "res://Engine/common_entity.gd"


#Ingame visible data
var player_name:String
var max_hearts = 3
var hearts = 0
var max_rupees = 99
var rupees = 0

var item_A = load("res://Items/Sword/Iron Sword.tscn")
var item_B


#Ingame invisible data
var speed = 60
var hitstun = 15

var current_state = _ENUMS.STATE.DEFAULT
var type = "PLAYER"

func _init():
	global_speed = speed
	global_hitstun_time = hitstun
	global_type = type
	global_max_hearts = max_hearts
#	global_hearts = hearts
	
func _physics_process(delta):
	
	match current_state:
		_ENUMS.STATE.DEFAULT:
			state_default()
		_ENUMS.STATE.ATTACK:
			state_attack()
	
	
func state_default():
	
	keyboard_loop()
	movement_loop()
	sprite_mov_loop()
	damage_loop()
	
	if dirMov != Vector2(0,0):
		animation_switch("walk_")
	else:
		animation_switch("idle_")
	
	if Input.is_action_just_pressed("a"):
		use_item_by_button(_ENUMS.BUTTON.A)
	if Input.is_action_just_pressed("b"):
		use_item_by_button(_ENUMS.BUTTON.B)
		
func state_attack():
	animation_switch("idle_")
	damage_loop()
	
	#To make able recieve damage while doing an attack
	movement_loop()
	dirMov = _DIRECTIONS.center

func keyboard_loop():
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	
	dirMov.x = -int(LEFT) + int(RIGHT)
	dirMov.y = -int(UP) + int(DOWN)
	
func use_item_by_button(button):
	var item_to_use

	match(button):
		_ENUMS.BUTTON.A:
			item_to_use = item_A
		_ENUMS.BUTTON.B:
			item_to_use = item_B

	if item_to_use != null:
		print("Tried to use an item")
		use_item(item_to_use)
	else:
		print("Has no item")
		
	
	