extends Node


func _ready():
	_GLOBAL_DATA.mapNode = $CurrentMap
	_GLOBAL_DATA.mapNode.initialize()
