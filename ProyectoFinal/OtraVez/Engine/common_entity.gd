extends KinematicBody2D

var GLOBAL_SPEED = 0

var dirMov = Vector2(0,0)
var spriteMov = "down"


func movement_loop():
	var motion = dirMov.normalized() * GLOBAL_SPEED
	move_and_slide(motion, Vector2(0,0))
	
func spriteMov_loop():
	match dirMov:
		_DIRECTIONS.left:
			spriteMov = "left"
		_DIRECTIONS.right:
			spriteMov = "right"
		_DIRECTIONS.up:
			spriteMov = "up"
		_DIRECTIONS.down:
			spriteMov = "down"
			
func animation_switch(animation):
	var newAnimation = str(animation, spriteMov)
	if $Animation.current_animation != newAnimation:
		$Animation.play(newAnimation)
