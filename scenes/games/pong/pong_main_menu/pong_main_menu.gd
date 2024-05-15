extends CanvasLayer

@onready var start_button: Button = %StartButton


func _ready() -> void:
	start_button.pressed.connect(on_start_button_pressed)


func on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/games/pong/pong_main/pong_main.tscn")
