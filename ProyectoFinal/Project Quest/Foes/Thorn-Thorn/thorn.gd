extends KinematicBody2D

enum DIRECTIONS {NONE, UP, DOWN, LEFT, RIGHT}

export (DIRECTIONS) var direction 

var dirMov
var speed = 100
var damage = 0.5

var type = _ENUMS.TYPE.FOE

var go_back = false

func _ready():
	add_to_group("shield")
	$Animation.play("default")
	match(direction):
		DIRECTIONS.UP:
			dirMov = _DIRECTIONS.up
		DIRECTIONS.DOWN:
			dirMov = _DIRECTIONS.down
		DIRECTIONS.LEFT:
			dirMov = _DIRECTIONS.left
		DIRECTIONS.RIGHT:
			dirMov = _DIRECTIONS.right
		DIRECTIONS.NONE:
			dirMov = _DIRECTIONS.center
	
func _physics_process(delta):
	
	var motion 
	if go_back:
		motion = dirMov.normalized() * -speed
	else:
		motion = dirMov.normalized() * speed
		
	move_and_slide(motion, Vector2(0,0))


func _on_HitBox_body_entered(body):
	if body.get("type") != _ENUMS.TYPE.PLAYER:
		go_back = not go_back
