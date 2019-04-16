extends Control

signal equipment_changed

var in_pause = false

func _ready():
	_SIGNAL_MANAGER.connect("update_inventory", self, "_on_Game_game_loaded")
	_SIGNAL_MANAGER.connect("update_counter", self, "update_counter")

func _on_Game_game_loaded():

	for child in get_node("GridContainer").get_children(): #We delete them as we are going to create new ones
		get_node("GridContainer").remove_child(child)

	for item in _GLOBAL_DATA.player.inventory:
		var new_slot = TextureButton.new()
		new_slot.texture_focused = load("res://Engine/Pause/item_selected.png")

		if item != null:
			new_slot.texture_normal = item.instance().get_node("Portrait").texture
		else:
			new_slot.texture_normal = load("res://Engine/Pause/empty.png")
			
		get_node("GridContainer").add_child(new_slot)

func _input(event):
	if event.is_action_pressed("pause") and !_GLOBAL_DATA.player.can_interact:
		$GridContainer.get_child(0).grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible
		in_pause = not in_pause

	if event.is_action_pressed("a") and in_pause:
		change_item(_ENUMS.BUTTON.A)
	if event.is_action_pressed("b") and in_pause:
		change_item(_ENUMS.BUTTON.B)


func change_item(button):
	var count = 0
	for slot in $GridContainer.get_children():
		if slot.has_focus():
			print(count)
			var item_to_place = _GLOBAL_DATA.player.inventory[count]
			match(button):
				_ENUMS.BUTTON.A:
					control_placement(item_to_place, _ENUMS.BUTTON.A)
				_ENUMS.BUTTON.B:
					control_placement(item_to_place, _ENUMS.BUTTON.B)
			emit_signal("equipment_changed")
		count += 1

func control_placement(item, button):
	match(button):
		_ENUMS.BUTTON.A:
			if _GLOBAL_DATA.player.item_B == item:
				_GLOBAL_DATA.player.item_B = _GLOBAL_DATA.player.item_A
			_GLOBAL_DATA.player.item_A = item
		_ENUMS.BUTTON.B:
			if _GLOBAL_DATA.player.item_A == item:
				_GLOBAL_DATA.player.item_A = _GLOBAL_DATA.player.item_B
			_GLOBAL_DATA.player.item_B = item
			
