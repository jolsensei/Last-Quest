extends Node

func _ready():
	_SIGNAL_MANAGER.connect("update_counter", self, "update_counter")
	_SIGNAL_MANAGER.connect("update_AB", self, "update_AB")
	

func _on_map_loaded():
	if _GLOBAL_DATA.player.item_A != null:
		$ItemA.texture = _GLOBAL_DATA.player.item_A.instance().get_node("Portrait").texture
		if _GLOBAL_DATA.player.item_A.instance().has_counter:
			$ItemA/CounterA.visible = true
			$ItemA/CounterA.frame = get_current_value(_GLOBAL_DATA.player.item_A.instance().name)
		else:
			$ItemA/CounterA.visible = false
	else:
		$ItemA.texture = load("res://Engine/Pause/empty.png")
		
		
	if _GLOBAL_DATA.player.item_B != null:
		$ItemB.texture = _GLOBAL_DATA.player.item_B.instance().get_node("Portrait").texture
		if _GLOBAL_DATA.player.item_B.instance().has_counter:
			$ItemB/CounterB.visible = true
			$ItemB/CounterB.frame = get_current_value(_GLOBAL_DATA.player.item_B.instance().name)
		else:
			$ItemB/CounterB.visible = false
	else:
		$ItemB.texture = load("res://Engine/Pause/empty.png")


func _on_PauseInventory_equipment_changed():
	_on_map_loaded()
	
func update_AB():
	_on_map_loaded()
	
func update_counter(number, item):
	var itemA = _GLOBAL_DATA.player.item_A.instance().name
	var itemB = _GLOBAL_DATA.player.item_B.instance().name
	match(item):
		itemA:
			$ItemA/CounterA.frame = number
		itemB:
			$ItemB/CounterB.frame = number

func get_current_value(item):
	match(item):
		"Bow":
			return _GLOBAL_DATA.player.arrows
