extends "res://Events/basic_event.gd"
#STONE
var picked = false
var throw = false

var dirMov = null
var max_amount = 1
var speed = 100

var type = _ENUMS.TYPE.TERRAIN
var damage = 2

export(String, FILE, "*.tscn") var mandatory_drop = null

func _ready():
	set_physics_process(false)
	set_process(false)

func _input(event):

	if Input.is_action_just_pressed("a") and _GLOBAL_DATA.player.can_interact and _GLOBAL_DATA.player.hands_free and !picked and _GLOBAL_DATA.player.bracelet_of_will:
		_SFX.play_sfx("lift")
		$Sprite/StaticBody2D/CollisionShape2D.disabled = true
		picked = true
		set_z_index(0)
		set_physics_process(true)
		_GLOBAL_DATA.player.hands_free = false
		Input.action_release("a")
		

	if Input.is_action_just_pressed("a") and picked and _GLOBAL_DATA.player.dirMov != Vector2(0,0):
		_SFX.play_sfx("throw")
		$Timer.start()
		type = _ENUMS.TYPE.PLAYER
		picked = false
		set_z_index(-1)
		_GLOBAL_DATA.player.hands_free = true
		dirMov = _GLOBAL_DATA.player.last_dirMov
		drop()
		Input.action_release("a")
		throw = true
		
	elif Input.is_action_just_pressed("a") and picked:
		_SFX.play_sfx("land")
		$Sprite/StaticBody2D/CollisionShape2D.disabled = false
		picked = false
		set_z_index(-1)
		set_physics_process(false)
		_GLOBAL_DATA.player.hands_free = true
		drop()
		Input.action_release("a")
		


func _physics_process(delta):
	if picked:
		self.global_position = _GLOBAL_DATA.player.get_node("Lift").global_position
		set_process_input(true)
	if throw:
		self.global_position += dirMov * speed * delta

func drop():
	var player_position = _GLOBAL_DATA.player.global_position
	match(_GLOBAL_DATA.player.spriteMov):
		"left":
			player_position.x -= 14
		"right":
			player_position.x += 14
		"down":
			player_position.y += 16
		"up":
			player_position.y -= 4
	self.global_position = player_position

func pot_break():
	picked = true
	_SFX.play_sfx("break_sound")
	$Sprite.frame = 1
	set_physics_process(false)
	set_process(false)
	$Area2D/CollisionShape2D.disabled = true
	$Sprite/StaticBody2D/CollisionShape2D.disabled = true
	$Animation.play("break")


func _on_Animation_animation_finished(anim_name):
	queue_free()
	
func _on_Timer_timeout():
	_SFX.play_sfx("break_sound")
	$Timer.stop()
	pot_break()


func _on_Area2D_body_entered(body):
	if body.get("type") != _ENUMS.TYPE.PLAYER and throw:
#		print(body)
		pot_break()
	_on_body_entered(body)


func _on_Area2D_body_exited(body):
	_on_body_exited(body)


