extends "res://Engine/common_entity.gd"

signal rupee_picked

#Ingame visible data
var player_name:String
var max_hearts = 3
var hearts = 0
var max_rupees = 99
var rupees = 0
var max_arrows = 10
var arrows = 10


var item_A = load("res://Items/Sword/Iron Sword.tscn")
var item_B = load("res://Items/Boomerang/Boomerang.tscn")

var inventory = []


#Ingame invisible data
var speed = 60
var hitstun = 15

var can_interact = false
var hands_free = true

var current_state = _ENUMS.STATE.DEFAULT
var type = _ENUMS.TYPE.PLAYER

func _init():
	global_speed = speed
	global_hitstun_time = hitstun
	global_type = type
	global_max_hearts = max_hearts
#	global_hearts = hearts

	inventory.resize(16)

	inventory[0] = load("res://Items/Sword/Iron Sword.tscn")
	inventory[4] = load("res://Items/Shield/Shield of Legend.tscn")
	inventory[5] = load("res://Items/Boomerang/Boomerang.tscn")
	inventory[6] = load("res://Items/Bow/Bow.tscn")
	
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
	
	
	if dirMov != Vector2(0,0) and !hands_free:
		animation_switch("walk_lift_")
	elif !hands_free:
		animation_switch("idle_lift_")
	elif  dirMov != Vector2(0,0):
		animation_switch("walk_")
	else:
		animation_switch("idle_")

	if Input.is_action_just_pressed("a") and !can_interact and hands_free:
		use_item_by_button(_ENUMS.BUTTON.A)
		
	if Input.is_action_just_pressed("b") and !can_interact and hands_free:
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

func add_rupees(rupees):
	self.rupees += rupees
	self.rupees = min(self.rupees, max_rupees)
	emit_signal("rupee_picked")
	
func heal(hearts):
	self.global_hearts += hearts
	global_hearts = min(global_hearts, global_max_hearts)
	
func give_arrows(arrows):
	self.arrows += arrows
	self.arrows = min(self.arrows, max_arrows)
	
	