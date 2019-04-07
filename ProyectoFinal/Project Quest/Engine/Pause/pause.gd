extends Control

func _on_Game_game_loaded():
	for item in _GLOBAL_DATA.player.inventory:
		var new_slot = TextureButton.new()
		new_slot.texture_focused = load("res://Engine/Pause/item_selected.png")
		
		if item != null:
			new_slot.texture_normal = item.get_node("Portrait").texture
		else:
			new_slot.texture_normal = load("res://Engine/Pause/empty.png")
			
		get_node("GridContainer").add_child(new_slot)

func _input(event):
	if event.is_action_pressed("pause"):
		$GridContainer.get_child(0).grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible



