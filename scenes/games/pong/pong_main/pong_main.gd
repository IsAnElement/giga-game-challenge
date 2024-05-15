extends CanvasLayer

@onready var paddle_one: Area2D = $PaddleOne
@onready var paddle_two: Area2D = $PaddleTwo
@onready var ball: Area2D = $Ball

@onready var player_one_score_label: Label = %PlayerOneScoreLabel
@onready var player_two_score_label: Label = %PlayerTwoScoreLabel

var player_one_score: int = 0
var player_two_score: int = 0


func _ready() -> void:
	GameEvents.ball_destroyed.connect(on_ball_destroyed)


func on_ball_destroyed(which: int) -> void:
	match which:
		0: player_two_score += 1
		1: player_one_score += 1
	ball.speed = 0
	ball.global_position = Vector2(960, 540)
	update_score()


func _process(delta: float) -> void:
	if paddle_two.global_position.y < ball.global_position.y:
		paddle_two.global_position.y += Constants.paddle_speed * delta
	elif paddle_two.global_position.y > ball.global_position.y:
		paddle_two.global_position.y -= Constants.paddle_speed * delta
	else:
		pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pong_start") and ball.speed == 0:
		match randi_range(0, 1):
			0: 
				ball.speed = Constants.pong_starting_speed
				ball.direction = Vector2.LEFT.rotated(deg_to_rad(randf_range(-60, 60)))
			1: 
				ball.speed = Constants.pong_starting_speed
				ball.direction = Vector2.RIGHT.rotated(deg_to_rad(randf_range(-60, 60)))
	elif event.is_action_pressed("pong_move_down"):
		paddle_one.global_position.y += Constants.paddle_speed * get_process_delta_time()
	elif event.is_action_pressed("pong_move_up"):
		paddle_one.global_position.y -= Constants.paddle_speed * get_process_delta_time()


func update_score() -> void:
	player_one_score_label.text = str(player_one_score)
	player_two_score_label.text = str(player_two_score)
