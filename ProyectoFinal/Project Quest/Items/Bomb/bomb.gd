extends "res://Events/basic_event.gd"

var picked = false
var throw = false

var dirMov = null
var max_amount = 3
var speed = 80

var type = _ENUMS.TYPE.TERRAIN
var damage = 2

var has_counter = true

func _ready():
	if get_parent().bombs > 0 and get_tree().get_nodes_in_group("bombs").size() < max_amount:
		add_to_group("bombs")
		
		$Explosion.start()
		$Animation.play("countdown")
		
		self.position = _GLOBAL_DATA.player.get_node("Lift").global_position
		picked = true
		set_z_index(1)
		_GLOBAL_DATA.player.hands_free = false
		_SFX.play_sfx("lift")
		$Sprite/StaticBody2D/CollisionShape2D.disabled = true
		get_parent().bombs -= 1
		_SIGNAL_MANAGER.update_counter(get_parent().bombs, self.name)
		$Explosion.start()
		
		var new_parent = get_parent().get_parent()
		get_parent().remove_child(self)
		new_parent.add_child(self)
	else:
		queue_free()
	
	

func _input(event):

	if Input.is_action_just_pressed("a") and _GLOBAL_DATA.player.can_interact and _GLOBAL_DATA.player.hands_free and !picked:
		_SFX.play_sfx("lift")
		$Sprite/StaticBody2D/CollisionShape2D.disabled = true
		picked = true
		set_z_index(1)
		set_physics_process(true)
		_GLOBAL_DATA.player.hands_free = false
		Input.action_release("a")
		

	if Input.is_action_just_pressed("a") and picked and _GLOBAL_DATA.player.dirMov != Vector2(0,0):
		_SFX.play_sfx("throw")
		$Timer.start(0.5)
		type = _ENUMS.TYPE.TERRAIN
		picked = false
		set_z_index(-1)
		_GLOBAL_DATA.player.hands_free = true
		dirMov = _GLOBAL_DATA.player.last_dirMov
		drop()
		Input.action_release("a")
		throw = true
		
	elif Input.is_action_just_pressed("a") and picked:
		_SFX.play_sfx("lay_bomb")
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
			player_position.x -= 12
		"right":
			player_position.x += 12
		"down":
			player_position.y += 16
		"up":
			player_position.y -= 4
	self.global_position = player_position


func _on_Area2D_body_entered(body):
	if body.get("type") != _ENUMS.TYPE.PLAYER and throw:
		$Timer.stop()
		$Timer.start(0.01)
	_on_body_entered(body)

func _on_Area2D_body_exited(body):
	_on_body_exited(body)


func _on_Timer_timeout():
	$Timer.stop()
	set_physics_process(false)
	$Sprite/StaticBody2D/CollisionShape2D.disabled = false
	throw = false
	

func _on_Explosion_timeout():
	if picked:
		_GLOBAL_DATA.player.hands_free = true
	_SFX.play_sfx("bomb_explode")
	var explode_animation = preload("res://Items/Bomb/Explosion/Bomb Explosion.tscn").instance()
	get_parent().add_child(explode_animation)
	explode_animation.global_transform = global_transform
	queue_free()

func give_to_player():
	_GLOBAL_DATA.player.inventory[7] = load("res://Items/Bomb/Bomb.tscn")
	_SIGNAL_MANAGER.update_inventory()
	_SIGNAL_MANAGER.show(true, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("BOMBS")))