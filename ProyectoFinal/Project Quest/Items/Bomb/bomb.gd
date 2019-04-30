extends Node

var picked = false
var throw = false

var dirMov = null
var max_amount = 1
var speed = 100

var type = _ENUMS.TYPE.TERRAIN
var damage = 2

var has_counter = true


func _ready():
	pass
#	if get_parent().bombs > 0 and get_tree().get_nodes_in_group("bombs").size() < max_amount:
#		self.position = _GLOBAL_DATA.player.get_node("Lift").global_position
#		add_to_group("bombs")
#
#		var new_parent = get_parent().get_parent()
#		get_parent().remove_child(self)
#		new_parent.add_child(self)
#
#		$Sprite/StaticBody2D/CollisionShape2D.disabled = true
#		picked = true
#		$Sprite.set_z_index(0)
#		set_physics_process(true)
#		_GLOBAL_DATA.player.hands_free = false

func _input(event):

	if Input.is_action_just_pressed("a") and _GLOBAL_DATA.player.can_interact and _GLOBAL_DATA.player.hands_free and !picked:
		_SFX.play_sfx("lift")
		$Sprite/StaticBody2D/CollisionShape2D.disabled = true
		picked = true
		$Sprite.set_z_index(1)
		set_physics_process(true)
		_GLOBAL_DATA.player.hands_free = false
		Input.action_release("a")
		

	if Input.is_action_just_pressed("a") and picked and _GLOBAL_DATA.player.dirMov != Vector2(0,0):
		_SFX.play_sfx("throw")
		type = _ENUMS.TYPE.TERRAIN
		picked = false
		$Sprite.set_z_index(0)
		_GLOBAL_DATA.player.hands_free = true
		dirMov = _GLOBAL_DATA.player.last_dirMov
		drop()
		Input.action_release("a")
		throw = true
		
	elif Input.is_action_just_pressed("a") and picked:
		_SFX.play_sfx("land")
		$Sprite/StaticBody2D/CollisionShape2D.disabled = false
		picked = false
		$Sprite.set_z_index(0)
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

func _on_Area2D_body_entered(body):
#	_on_body_entered(body)
	_GLOBAL_DATA.player.can_interact = true
	set_process_input(true)

func _on_Area2D_body_exited(body):
#	_on_body_exited(body)
	_GLOBAL_DATA.player.can_interact = false
	set_process_input(false)
