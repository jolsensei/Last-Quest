extends KinematicBody2D

const SPEED = 60

var dirMov = Vector2(0,0)
var spriteMov = "down"

func _physics_process(delta):
	keyboard_loop()
	movement_loop()
	spriteMov_loop()
	
	if dirMov != Vector2(0,0):
		animation_switch("walk_")
	else:
		animation_switch("idle_")

func keyboard_loop():
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	
	dirMov.x = -int(LEFT) + int(RIGHT)
	dirMov.y = -int(UP) + int(DOWN)
	
func movement_loop():
	var motion = dirMov.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))
	
func spriteMov_loop():
	match dirMov:
		Vector2(-1,0):
			spriteMov = "left"
		Vector2(1,0):
			spriteMov = "right"
		Vector2(0,-1):
			spriteMov = "up"
		Vector2(0,1):
			spriteMov = "down"
			
func animation_switch(animation):
	var newAnimation = str(animation, spriteMov)
	if $Animation.current_animation != newAnimation:
		$Animation.play(newAnimation)
	