extends "res://Engine/common_entity.gd"

var movetimer_length = 100
var movetimer = 0

var speed = 0 #20
var damage = 0.25
var hitstun = 15
var max_hearts = 1

var type = _ENUMS.TYPE.FOE

var shoot = load("res://Foes/Spirak/Shoot/Spirak Shoot.tscn")

func _init():
	global_speed = speed
	global_hitstun_time = hitstun
	global_max_hearts = max_hearts
	global_type = type

func _ready():
	dirMov = _DIRECTIONS.random()
	
	if _GLOBAL_DATA.player.emissary_of_the_edge:
		$ChaseArea/ChaseArea.shape.set_points([Vector2(0,0), Vector2(20, 40), Vector2(-20, 40)])
#		print($ChaseArea/ChaseArea.shape.get_points())
		


func _physics_process(delta):
	movement_loop()
	damage_loop()

	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 or is_on_wall():
		dirMov = _DIRECTIONS.random() 
		movetimer = movetimer_length

	sprite_mov_loop()
	if dirMov != Vector2(0,0):
		animation_switch("walk_")
	else:
		animation_switch("idle_")


func _on_ChaseArea_body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER :
		use_item(shoot)
