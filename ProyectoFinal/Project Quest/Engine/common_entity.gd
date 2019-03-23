extends KinematicBody2D

var dirMov = Vector2(0,0)
var spriteMov = "down"
var knock_dir = Vector2(0,0)

var global_hitstun = 0
var global_hitstun_time = 10
var global_type = "FOE"
var global_hearts = 1
var global_speed = 0

func movement_loop():
	var motion
	
	if global_hitstun == 0:
		motion = dirMov.normalized() * global_speed
	else:
		motion = knock_dir.normalized() * global_speed * 1.5
		
	move_and_slide(motion, Vector2(0,0))
	
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
	for area in $HitBox.get_overlapping_areas():
		var body = area.get_parent()
		if global_hitstun == 0 and body.get("damage") != null and body.get("type") != global_type:
			global_hearts -= body.get("damage")
			global_hitstun = global_hitstun_time
			knock_dir = global_transform.origin - body.global_transform.origin
			
func use_item(item):
	var new_item = item.instance()
	new_item.add_to_group(str(new_item, self))
	add_child(new_item)
	if get_tree().get_nodes_in_group(str(new_item, self)).size() > new_item.max_amount:
		new_item.queue_free()
