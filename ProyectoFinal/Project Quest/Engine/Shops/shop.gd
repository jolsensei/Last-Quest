extends Control

var exit_pressed
var yes_pressed
var no_pressed
var item_selected
var arrows
var item1_selected
var item2_selected
var item3_selected
var exit_focus

var item_to_buy = 1

var item1
var item2
var item3

var currently_shopping = false

func _ready():
	_SIGNAL_MANAGER.connect("start_shop", self, "start_shop")
	set_process_input(false)
	
func _input(event):
	refresh_focus()
	update_inputs()
	update_price()

	match(true):
		exit_pressed:
			close()
			Input.action_release("a")
			_SFX.play_sfx("message_finish")
		yes_pressed:
			buy()
		no_pressed:
			cancel_buy()
		item_selected:
			ask_to_buy()
		arrows:
			_SFX.play_sfx("cursor")
	
	
func update_inputs():
	exit_pressed = Input.is_action_just_pressed("a") and $Exit.has_focus() and currently_shopping
	yes_pressed = Input.is_action_just_pressed("a") and $YesNo/Yes.has_focus() and currently_shopping
	no_pressed = Input.is_action_just_pressed("a") and $YesNo/No.has_focus() and currently_shopping
	item_selected = Input.is_action_just_pressed("a") and ($Item1.has_focus() or $Item2.has_focus() or $Item3.has_focus()) and currently_shopping
	arrows = Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")
	
func refresh_focus():
	item1_selected = $Item1.has_focus()
	item2_selected = $Item2.has_focus()
	item3_selected = $Item3.has_focus()
	exit_focus = $Exit.has_focus()
	
func ask_to_buy():
	$YesNo.visible = true
	$Exit.visible = false
	$YesNo/Yes.grab_focus()
	
	$Text.text = tr("T_CONFIRMATION")
	
func cancel_buy():
	$YesNo.visible = false
	$Exit.visible = true
	
	match(item_to_buy):
		1:
			$Item1.grab_focus()
		2:
			$Item2.grab_focus()
		3:
			$Item3.grab_focus()
			
	$Text.text = tr("S_TAKE_YOUR_TIME")

func buy():
	
	var cost
	var item_to_sell
	
	match(item_to_buy):
		1:
			cost = item1.price
			item_to_sell = item1
		2:
			cost = item2.price
			item_to_sell = item2
		3:
			cost = item3.price
			item_to_sell = item3
			
			
	if cost > _GLOBAL_DATA.player.rupees:
		$Text.text = tr("S_NOT_RUPEES")
	else:
		_SFX.play_sfx("wallet")
		$Text.text = tr("S_THANKS")
		_GLOBAL_DATA.player.add_rupees(-cost)
		close()
		item_to_sell.give_to_player()
		
	
	
func close():
	on_shop(false)
	
func start_shop(item1, item2, item3):
	
	$Exit.visible = true
	$YesNo.visible = false
	
	$Text.text = tr("S_WELCOME")
	$YesNo/Yes/Label.text = tr("T_YES")
	$YesNo/No/Label.text = tr("T_NO")
	$Exit/Label.text = tr("T_EXIT")
	
	self.item1 = item1
	self.item2 = item2
	self.item3 = item3
	
	$Item1.texture_normal = item1.get_node("Portrait").texture
	$Item2.texture_normal = item2.get_node("Portrait").texture
	$Item3.texture_normal = item3.get_node("Portrait").texture
	
	$Item1.grab_focus()
	
	on_shop(true)
	
#	update_inputs()
	update_price()
	
	
func on_shop(boolean):
	currently_shopping = boolean
	set_process_input(boolean)
	get_tree().paused = boolean
	visible = boolean
	
func update_price():

	match(true):
		item1_selected:
			item_to_buy = 1
			$Sprite/Price.text = str(item1.price)
		item2_selected:
			item_to_buy = 2
			$Sprite/Price.text = str(item2.price)
		item3_selected:
			item_to_buy = 3
			$Sprite/Price.text = str(item3.price)
			
	if exit_focus:
		$Sprite/Price.text = ""
	