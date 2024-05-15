extends Area2D

@export var player_int: int

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var paddle_shape: Polygon2D = $PaddleShape


func _ready() -> void:
	area_entered.connect(on_area_entered)
	paddle_shape.polygon = PackedVector2Array([Vector2(0, 0), Vector2(Constants.paddle_width, 0), Vector2(Constants.paddle_width, Constants.paddle_height), Vector2(0, Constants.paddle_height)])
	collision_shape_2d.shape.size = Vector2(Constants.paddle_width, Constants.paddle_height)
	collision_shape_2d.position.x = Constants.paddle_width / 2.0


func on_area_entered(other_area: Area2D) -> void:
	other_area.direction = get_new_direction(other_area)
	other_area.speed *= Constants.pong_hit_speed_increase


func get_new_direction(other_area: Area2D) -> Vector2:
	var middle_of_paddle_y: float = global_position.y + collision_shape_2d.shape.size.y / 2.0
	var distance_from_middle: float = middle_of_paddle_y - other_area.global_position.y
	
	if player_int == 0:
		return Vector2.RIGHT.rotated(deg_to_rad(-distance_from_middle * 1.5))
	else:
		return Vector2.LEFT.rotated(deg_to_rad(distance_from_middle * 1.5))
