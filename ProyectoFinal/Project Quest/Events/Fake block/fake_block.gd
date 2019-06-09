extends "res://Events/basic_event.gd"
#FAKE
var picked = false

var dirMov = null
var max_amount = 1

var type = _ENUMS.TYPE.TERRAIN

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


func _on_Area2D_body_entered(body):
	_on_body_entered(body)


func _on_Area2D_body_exited(body):
	_on_body_exited(body)
