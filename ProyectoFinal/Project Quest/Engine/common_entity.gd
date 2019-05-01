extends KinematicBody2D

signal damaged

var dirMov = Vector2(0,0)
var last_dirMov = Vector2(0,1)
var spriteMov = "down"
var knock_dir = Vector2(0,0)

var global_hitstun = 0
var global_hitstun_time = 10
var global_type = _ENUMS.TYPE.FOE

var global_max_hearts = 0
var global_hearts

var global_speed = 0

var texture_default = null
var texture_damage = null

func _ready():
	global_hearts = global_max_hearts
	texture_default = $Sprite.texture
	texture_damage = load($Sprite.texture.get_path().replace(".png","_damage.png"))

func movement_loop():
	var motion
	
	if global_hitstun == 0:
		motion = dirMov.normalized() * global_speed
	else:
		motion = knock_dir.normalized() * 125
		
	move_and_slide(motion, Vector2(0,0))
	if dirMov != _DIRECTIONS.center and _DIRECTIONS.cardinal_directions.has(dirMov):
		last_dirMov = dirMov
	
func sprite_mov_loop():
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

func damage_loop():
	if global_hitstun > 0:
		global_hitstun -= 1
		$Sprite.texture = texture_damage
	else:
		$Sprite.texture = texture_default
		if global_type == _ENUMS.TYPE.FOE and global_hearts <=0:
			foe_death()
		if global_type == _ENUMS.TYPE.PLAYER and global_hearts <=0:
			get_tree().quit()
	for area in $HitBox.get_overlapping_areas():
		var body = area.get_parent()
		if global_hitstun == 0 and body.get("damage") != null and body.get("type") != global_type  and body.get("type") != _ENUMS.TYPE.TERRAIN:
			emit_signal("damaged")
			if global_type == _ENUMS.TYPE.PLAYER:
				_SFX.play_sfx("link_hurt")
			else:
				_SFX.play_sfx("enemy_hit")
				
			global_hearts -= body.get("damage")
			global_hitstun = global_hitstun_time
			knock_dir = global_transform.origin - body.global_transform.origin
			if body.get_groups().has("destroy_on_hit"):
				body.queue_free()
			
func use_item(item):
	var new_item = item.instance()
	new_item.add_to_group(str(item, self))
	add_child(new_item)
	if get_tree().get_nodes_in_group(str(item, self)).size() > new_item.max_amount:
		new_item.queue_free()
		
func foe_death():
	_SFX.play_sfx("enemy_dies")
	var death_animation = preload("res://Foes/enemy_death.tscn").instance()
	get_parent().add_child(death_animation)
	death_animation.global_transform = global_transform
	queue_free()
	
	
	
	
