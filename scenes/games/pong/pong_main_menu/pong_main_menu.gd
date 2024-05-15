extends CanvasLayer

@onready var start_button: Button = %StartButton
@onready var start_alternate_one_button: Button = %StartAlternateOneButton


func _ready() -> void:
	start_button.button_up.connect(on_start_button_pressed)
	start_alternate_one_button.button_up.connect(on_start_alternate_one_button_pressed)


func on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/games/pong/pong_basic/pong_main/pong_main.tscn")


func on_start_alternate_one_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/games/pong/pong_two/pong_two_main/pong_two_main.tscn")
