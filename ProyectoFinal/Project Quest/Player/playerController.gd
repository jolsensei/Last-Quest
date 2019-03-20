extends "res://Engine/common_entity.gd"

var current_state = _ENUMS.STATE.DEFAULT

func _init():
	GLOBAL_SPEED = _GLOBAL_DATA.playerObject.speed
	
func _physics_process(delta):
	
	match current_state:
		_ENUMS.STATE.DEFAULT:
			state_default()
		_ENUMS.STATE.ATTACK:
			state_attack()
	
	
func state_default():
	
	keyboard_loop()
	movement_loop()
	spriteMov_loop()
	
	if dirMov != Vector2(0,0):
		animation_switch("walk_")
	else:
		animation_switch("idle_")
	
	if Input.is_action_just_pressed("a"):
		use_item(_ENUMS.BUTTON.A)
	if Input.is_action_just_pressed("b"):
		use_item(_ENUMS.BUTTON.B)
		
func state_attack():
	animation_switch("idle_")

func keyboard_loop():
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	
	dirMov.x = -int(LEFT) + int(RIGHT)
	dirMov.y = -int(UP) + int(DOWN)
	
func use_item(button):
	var item_to_use
	
	match(button):
		_ENUMS.BUTTON.A:
			item_to_use = _GLOBAL_DATA.playerObject.get_item_A()
		_ENUMS.BUTTON.B:
			item_to_use = _GLOBAL_DATA.playerObject.get_item_B()
	
	if item_to_use != null and item_to_use is Item:
		print("Tried to use " + item_to_use.name)
		var using_item = item_to_use.scene.instance()
		add_child(using_item)
	else:
		print("Has no item")
	
	