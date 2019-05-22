extends Node2D

func give_to_player():
	_GLOBAL_DATA.player.emissary_of_the_edge = true
	_GLOBAL_DATA.player.get_node("Sprite").texture = load("res://Player/emissary_of_the_edge_robes.png")
	_GLOBAL_DATA.player.texture_default = load("res://Player/emissary_of_the_edge_robes.png")
	_GLOBAL_DATA.player.texture_damage = load("res://Player/emissary_of_the_edge_robes_damage.png")
	_SIGNAL_MANAGER.update_inventory()
	_SIGNAL_MANAGER.show(true, $Portrait.texture, _TRANSLATION_MANAGER.translate(tr("EMISSARY")))
