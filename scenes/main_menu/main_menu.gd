extends CanvasLayer


@onready var pong_button: Button = %PongButton


func _ready() -> void:
	pong_button.pressed.connect(on_pong_button_pressed)


func on_pong_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/games/pong/pong_main/pong_main.tscn")


