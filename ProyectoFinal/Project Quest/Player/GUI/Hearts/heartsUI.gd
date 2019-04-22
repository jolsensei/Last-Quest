extends CanvasLayer


const HEART_ROW_SIZE = 6
const HEART_OFFSET = 10

func _ready():
	_SIGNAL_MANAGER.connect("update_hearts", self, "update_hearts")

func update_hearts():
	_on_map_loaded()

func _process(delta):
	for heart in $Hearts.get_children():
		var index = heart.get_index()

		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x,y)

		var last_heart = floor(_GLOBAL_DATA.player.global_hearts)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (_GLOBAL_DATA.player.global_hearts - last_heart) * 4
		if index < last_heart:
			heart.frame = 4


func _on_map_loaded():
	for child in  $Hearts.get_children(): #We delete them as we are going to create new ones
		 $Hearts.remove_child(child)
	
	for i in _GLOBAL_DATA.player.global_max_hearts:
		var new_heart = Sprite.new()
		new_heart.texture = $Hearts.texture
		new_heart.hframes = $Hearts.hframes
		$Hearts.add_child(new_heart)
