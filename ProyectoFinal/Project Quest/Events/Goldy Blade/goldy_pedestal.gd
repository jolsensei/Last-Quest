extends "res://Events/basic_event.gd"

export var opened = false
export(String, FILE, "*.tscn") var item_inside

func _ready():
	if opened:
		$Sprite.frame = 1    
	$Sprite.z_index = 0

func _input(event):
	
	if Input.is_action_just_pressed("a") and _GLOBAL_DATA.player.can_interact and !opened:
		var instanced_item_inside = load(item_inside).instance()
		
		_GLOBAL_DATA.player.get_node("Sprite").frame = 10 #Get object
		_GLOBAL_DATA.player.get_node("GetItem").texture = instanced_item_inside.get_node("Portrait").texture
		$Sprite.frame = 1                                 #Chest opened
		
		if instanced_item_inside.has_method('give_to_player'):
			instanced_item_inside.give_to_player()
		
		opened = true

func _on_Area2D_body_entered(body):
	_on_body_entered(body)
	$Sprite.z_index = 1


func _on_Area2D_body_exited(body):
	_on_body_exited(body)
	$Sprite.z_index = 0


func _on_Front_body_entered(body):
	_on_body_exited(body)
	$Sprite.z_index = 0


func _on_Front_body_exited(body):
	_on_body_entered(body)
	$Sprite.z_index = 1
