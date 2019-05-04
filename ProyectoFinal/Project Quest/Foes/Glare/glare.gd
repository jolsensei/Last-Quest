extends "res://Engine/common_entity.gd"

var movetimer_length = 15
var movetimer = 0

var speed = 10
var damage = 0.5
var hitstun = 15
var max_hearts = 2

var type = _ENUMS.TYPE.FOE

var chase = false

func _init():
	global_speed = speed
	global_hitstun_time = hitstun
	global_max_hearts = max_hearts

func _ready():
	dirMov = _DIRECTIONS.random()
	$Animation.play("default")
	
	
func _physics_process(delta):
	if chase:
		var direction = (_GLOBAL_DATA.player.global_position - self.global_position).normalized()
		move_and_slide(direction*speed)
		
	movement_loop()
	damage_loop()
	
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 or is_on_wall():
		dirMov = _DIRECTIONS.random() 
		movetimer = movetimer_length


func _on_Area2D_body_entered(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		chase = true
		speed = 40


func _on_Area2D_body_exited(body):
	if body.get("type") == _ENUMS.TYPE.PLAYER:
		chase = false
		speed = 10
