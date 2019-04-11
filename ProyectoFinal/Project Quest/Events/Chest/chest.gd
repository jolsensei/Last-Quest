extends "res://Events/basic_event.gd"

var opened = false
export(String, FILE, "*.tscn") var item_inside

func _ready():
	item_inside = load(item_inside)

func _input(event):
#	print("Test")
	if Input.is_action_just_pressed("a") and _GLOBAL_DATA.player.can_interact and !opened:
		_GLOBAL_DATA.player.get_node("Sprite").frame = 10 #Get object
		_GLOBAL_DATA.player.get_node("GetItem").texture = item_inside.instance().get_node("Portrait").texture
		$Sprite.frame = 1                                 #Chest opened
		
		item_inside.instance().give_to_player()
		
		opened = true

func _on_Area2D_body_entered(body):
	_on_body_entered(body)


func _on_Area2D_body_exited(body):
	_on_body_exited(body)
