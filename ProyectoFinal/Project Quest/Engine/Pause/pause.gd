extends Control

signal equipment_changed

var in_pause = false
var first_time = true

func _ready():
	translate()
	_SIGNAL_MANAGER.connect("update_inventory", self, "_on_Game_game_loaded")
	_SIGNAL_MANAGER.connect("update_counter", self, "update_counter")
	_SIGNAL_MANAGER.connect("update_collection", self, "update_collection")

func update_collection():
	$Collection/Hearts.frame = _GLOBAL_DATA.player.heart_pieces
	$Collection/Bracelet.visible = _GLOBAL_DATA.player.bracelet_of_will
	$Collection/Boots.visible = _GLOBAL_DATA.player.wind_boots
	$Collection/Doge.visible = _GLOBAL_DATA.player.doge_badge
	$Collection/Emissary.visible = _GLOBAL_DATA.player.emissary_of_the_edge
	$Collection/Wallet.visible = _GLOBAL_DATA.player.big_wallet
	$Collection/Band.visible = _GLOBAL_DATA.player.head_band
	
	
func _on_Game_game_loaded():
	
	update_collection()
	
	for child in $Inventory/GridContainer.get_children(): #We delete them as we are going to create new ones
		$Inventory/GridContainer.remove_child(child)

	for item in _GLOBAL_DATA.player.inventory:
		var new_slot = TextureButton.new()
		new_slot.texture_focused = load("res://Engine/Pause/item_selected.png")

		if item != null:
			new_slot.texture_normal = item.instance().get_node("Portrait").texture
		else:
			new_slot.texture_normal = load("res://Engine/Pause/empty.png")
			
		$Inventory/GridContainer.add_child(new_slot)

func _input(event):  #TODO This should be replaced with a true match
	if event.is_action_pressed("pause") and !_GLOBAL_DATA.player.can_interact:
		_SFX.play_sfx("map")
		$Inventory/GridContainer.get_child(0).grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible
		in_pause = not in_pause
		normal_state()
		if !in_pause and $Collection.visible:
			change_visibility()

	if event.is_action_pressed("a") and in_pause:
		change_item(_ENUMS.BUTTON.A)
	if event.is_action_pressed("b") and in_pause:
		change_item(_ENUMS.BUTTON.B)
	if in_pause and (event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right")):
		_SFX.play_sfx("cursor")
	if event.is_action_pressed("a") and in_pause and ($TextureButton.has_focus() or $TextureButton2.has_focus()):
		$Timer.start()
		$Anim.play("flip")
		var bottom_right = $TextureButton.has_focus()
		var bottom_left = $TextureButton2.has_focus()
		match(true):
			bottom_right:
				$Buttons.play("press_r")
			bottom_left:
				$Buttons.play("press_l")
	if event.is_action_pressed("a") and in_pause and $Collection/SaveExit/Save.has_focus():
		_SAVE_SYSTEM.save_game()
		save_animation()
	if event.is_action_pressed("a") and in_pause and $Collection/SaveExit/Exit.has_focus():
		ask_go_to_title()
		Input.action_release("a") #Looks like event and action release are not the same 
	if event.is_action_pressed("a") and in_pause and $Collection/YesNo/Yes.has_focus():
		go_to_title()
		_SAVE_SYSTEM.delete_temp()
	if Input.is_action_just_pressed("a") and in_pause and $Collection/YesNo/No.has_focus():
		normal_state()
		$Collection/SaveExit/Exit.grab_focus()
		
	if event.is_action_pressed("l") and in_pause:
		$TextureButton2.grab_focus()
		$Timer.start()
		$Anim.play("flip")
		$Buttons.play("press_l")
	if event.is_action_pressed("r") and in_pause:
		$TextureButton.grab_focus()
		$Timer.start()
		$Anim.play("flip")
		$Buttons.play("press_r")
	
func _on_Timer_timeout():
	change_visibility()

func change_item(button):
	var count = 0
	for slot in $Inventory/GridContainer.get_children():
		if slot.has_focus():
#			print(count)
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

func change_visibility():
	$Collection.visible = not $Collection.visible
	$Inventory.visible = not $Inventory.visible
	$Inventory/GridContainer.visible = not $Inventory/GridContainer.visible

func ask_go_to_title():
	$Collection/SaveExit.visible = false
	$Collection/YesNo.visible = true
	$TextureButton.visible = false
	$TextureButton2.visible = false
	$BackToTitle.visible = true
	
	$Collection/YesNo/No.grab_focus()
	$Anim.stop(true)
	$Saved.visible = false

func go_to_title():
	Input.action_release("a")
	get_tree().paused = false
#	get_tree().quit()
	_CURRENT_MAP.restart()
	get_tree().change_scene("res://Engine/Menus/Title/Title.tscn")
	
func save_animation():
	$Saved.visible = true
	$Anim.play("saved")
	
func normal_state():
	$Collection/SaveExit.visible = true
	$Collection/YesNo.visible = false
	$TextureButton.visible = true
	$TextureButton2.visible = true
	$BackToTitle.visible = false
	$Saved.visible = false
	
func translate():
	$Collection/YesNo/No/Label.text = tr("T_NO")
	$Collection/YesNo/Yes/Label.text = tr("T_YES")

	$Collection/SaveExit/Exit/Label.text = tr("T_EXIT")
	$Collection/SaveExit/Save/Label.text = tr("T_SAVE")
	
	$BackToTitle.text = tr("T_CONFIRMATION")
	$Saved.text = tr("T_DATA_SAVED")
	
	
	
