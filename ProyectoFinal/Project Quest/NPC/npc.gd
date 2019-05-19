extends "res://Events/basic_event.gd"

export(String) var dialog
enum TYPE {OLD_MAN, GIRL_1, GIRL_2, GIRL_3, DOG}
export (TYPE) var NPC_TYPE

func _ready():
	match(NPC_TYPE):
		TYPE.OLD_MAN:
			$Sprite.texture = load("res://NPC/Old man/old_man.png")
		TYPE.GIRL_1:
			pass

func _input(event):
	if Input.is_action_just_pressed("a") and _GLOBAL_DATA.player.can_interact:
		watch_player()
		_SIGNAL_MANAGER.show(false, null, _TRANSLATION_MANAGER.translate(tr(dialog)))


func _on_Area2D_body_entered(body):
	_on_body_entered(body)


func _on_Area2D_body_exited(body):
	_on_body_exited(body)
	
func watch_player():
	print(_GLOBAL_DATA.player.last_dirMov)
	match(_GLOBAL_DATA.player.last_dirMov):
		_DIRECTIONS.down:
			$Sprite.frame = 1
		_DIRECTIONS.up:
			$Sprite.frame = 0
		_DIRECTIONS.left:
			$Sprite.frame = 2
		_DIRECTIONS.right:
			$Sprite.frame = 3

