extends "res://Engine/common_entity.gd"

signal rupee_picked
signal key_picked

#Ingame visible data
export var player_name:String
export var max_hearts = 3
export var hearts = 3

export var heart_pieces = 0

export var max_rupees = 99
export var rupees = 0

export var max_arrows = 10
export var arrows = 10

export var max_bombs = 10
export var bombs = 10

export var max_keys = 9
export var keys = 0

export var boss_key = false

export var bracelet_of_will = false

export var wind_boots = false
export var stamina = 14

export var doge_badge = false

export var emissary_of_the_edge = false

export var big_wallet = false

export var head_band = false


export var item_A:Resource = load("res://Items/Sword/Iron Sword.tscn")
export var item_B:Resource #= load("res://Items/Boomerang/Boomerang.tscn")

export var inventory = []


#Ingame invisible data
export var speed = 60
export var hitstun = 15

export var can_interact = false
export var hands_free = true

export var current_state = _ENUMS.STATE.DEFAULT
export var type = _ENUMS.TYPE.PLAYER

export var last_position:Vector2 = Vector2(1592,1570) #1600-1600
export var last_map:int

func _init():
	global_speed = speed
	global_hitstun_time = hitstun
	global_type = type

	inventory.resize(16)

	#inventory[0] = load("res://Items/Sword/Iron Sword.tscn")
	#inventory[1] = load("res://Items/Goldy Blade/Goldy Blade.tscn")
	#inventory[2] = load("res://Items/Warrior's Shield/Warrior's Shield.tscn")
	#inventory[3] = load("res://Items/Shield/Shield of Legend.tscn")
	#inventory[5] = load("res://Items/Boomerang/Boomerang.tscn")
	#inventory[6] = load("res://Items/Bow/Bow.tscn")
	#inventory[7] = load("res://Items/Bomb/Bomb.tscn")
	
func _ready():
	_SIGNAL_MANAGER.connect("game_over", self, "game_over")
	global_max_hearts = max_hearts
	global_hearts = hearts
	can_interact = false
	hands_free = true
	
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
		
	if Input.is_action_just_pressed("r") and wind_boots:
		use_wind_boots()
		_on_Boots_timeout() #To avoid exploit
	elif Input.is_action_just_released("r") and wind_boots:
		stop_wind_boots()


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
	
func add_keys(keys):
	self.keys += keys
	self.keys = min(self.keys, max_keys)
	emit_signal("key_picked")
	
func heal(hearts):
	if head_band:
		hearts *= 2
	self.global_hearts += hearts
	global_hearts = min(global_hearts, global_max_hearts)
	
func give_arrows(arrows):
	self.arrows += arrows
	self.arrows = min(self.arrows, max_arrows)
	
func give_bombs(bombs):
	self.bombs += bombs
	self.bombs = min(self.bombs, max_bombs)
	
func use_wind_boots():
	global_speed = 80
	$Animation.playback_speed = 2
	$Stamina.visible = true
	$Boots.start()
	
func stop_wind_boots():
	global_speed = 60
	$Animation.playback_speed = 1
	

func _on_Boots_timeout():
	if Input.is_action_pressed("r") and stamina > 0:
		stamina -= 1
#		_SFX.play_sfx("boots")
	else:
		stamina += 1
		
	if stamina == 0:
		stop_wind_boots()
	if stamina >= 15:
		stamina = 14
		$Stamina.visible = false
		$Boots.stop()
		
	$Stamina.frame = stamina
	
func game_over():
	type = _ENUMS.TYPE.TERRAIN
	$Animation.stop(true)
	set_physics_process(false)
	current_state = _ENUMS.STATE.ATTACK
	_BGM.stop_bgm()
	$GameOver.play("game_over")
	_SFX.play_sfx("link_dies")

func _on_GameOver_animation_finished(anim_name):
	match(anim_name):
		"game_over":
			_SAVE_SYSTEM.delete_temp()
			get_tree().change_scene("res://Engine/Menus/Game over/Game over.tscn")
			_CURRENT_MAP.restart()
			
