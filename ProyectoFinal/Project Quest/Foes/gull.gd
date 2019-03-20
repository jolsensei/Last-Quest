extends "res://Engine/common_entity.gd"

var movetimer_length = 15
var movetimer = 0

var SPEED = 0

func _init():
	GLOBAL_SPEED = SPEED

func _ready():
	dirMov = _DIRECTIONS.random()
	
	
func _physics_process(delta):
	movement_loop()
	
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 or is_on_wall():
		dirMov = _DIRECTIONS.random() 
		movetimer = movetimer_length
		
	spriteMov_loop()
	if dirMov != Vector2(0,0):
		animation_switch("walk_")
	else:
		animation_switch("idle_")
	