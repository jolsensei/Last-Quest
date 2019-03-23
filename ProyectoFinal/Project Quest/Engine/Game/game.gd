extends Node


func _ready():
	_GLOBAL_DATA.map = $CurrentMap
	_GLOBAL_DATA.map.initialize()