extends CanvasLayer

@onready var paddle_one: Area2D = $PaddleOne
@onready var paddle_two: Area2D = $PaddleTwo
@onready var ball: Area2D = $Ball

@onready var player_one_score_label: Label = %PlayerOneScoreLabel
@onready var player_two_score_label: Label = %PlayerTwoScoreLabel
@onready var player_wins_label: Label = %PlayerWinsLabel


var player_one_down: bool = false
var player_one_up: bool = false
var player_one_score: int = 0
var player_two_score: int = 0
var player_two_ai_target: Vector2 = Vector2(0, Constants.paddle_height / 2.0)



func _ready() -> void:
	GameEvents.ball_destroyed.connect(on_ball_destroyed)
	paddle_two.global_position.x = 1920 - 10 - Constants.paddle_width


func on_ball_destroyed(which: int) -> void:
	match which:
		0: player_two_score += 1
		1: player_one_score += 1
	reset_to_center()
	
	if player_one_score >= Constants.score_to_win:
		on_player_win(0)
	elif player_two_score >= Constants.score_to_win:
		on_player_win(1)


func _process(delta: float) -> void:
	if paddle_two.global_position.y + Constants.paddle_height / 2.0 < ball.global_position.y:
		paddle_two.global_position.y += Constants.paddle_speed * delta
	elif paddle_two.global_position.y + Constants.paddle_height / 2.0 > ball.global_position.y:
		paddle_two.global_position.y -= Constants.paddle_speed * delta

	if player_one_down:
		paddle_one.global_position.y += Constants.paddle_speed * delta
	elif player_one_up:
		paddle_one.global_position.y -= Constants.paddle_speed * delta
	
	paddle_one.global_position.y = clamp(paddle_one.global_position.y, 0, 1080 - Constants. paddle_height)
	paddle_two.global_position.y = clamp(paddle_two.global_position.y, 0, 1080 - Constants. paddle_height)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pong_start") and ball.speed == 0:
		if player_one_score >= Constants.score_to_win or player_two_score >= Constants.score_to_win:
			player_one_score = 0
			player_two_score = 0
			player_wins_label.visible = false
			update_score()
		else:
			match randi_range(0, 1):
				0: 
					ball.speed = Constants.pong_starting_speed
					ball.direction = Vector2.LEFT.rotated(deg_to_rad(randf_range(-60, 60)))
				1: 
					ball.speed = Constants.pong_starting_speed
					ball.direction = Vector2.RIGHT.rotated(deg_to_rad(randf_range(-60, 60)))
	elif event.is_action_pressed("pong_move_down"):
		player_one_down = true
	elif event.is_action_released("pong_move_down"):
		player_one_down = false
	elif event.is_action_pressed("pong_move_up"):
		player_one_up = true
	elif event.is_action_released("pong_move_up"):
		player_one_up = false


func reset_to_center() -> void:
	ball.speed = 0
	ball.global_position = Vector2(960, 540)
	update_score()


func update_score() -> void:
	player_one_score_label.text = str(player_one_score)
	player_two_score_label.text = str(player_two_score)


func on_player_win(which: int) -> void:
	var victory_string: String
	match which:
		0: victory_string = "PLAYER ONE WINS!"
		1: victory_string = "PLAYER TWO WINS!"
	player_wins_label.text = victory_string
	player_wins_label.visible = true


func reset_game() -> void:
	player_one_score = 0
	player_two_score = 0
	player_wins_label.visible = false
	reset_to_center()
