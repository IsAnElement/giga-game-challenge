extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var direction: Vector2 = Vector2.ZERO
var speed: float = 0


func _ready() -> void:
	collision_shape_2d.shape.radius = Constants.ball_radius


func _process(delta: float) -> void:
	queue_redraw()
	global_position += direction * speed * delta


func _draw() -> void:
	draw_circle(Vector2.ZERO, collision_shape_2d.shape.radius as float, Color.BLACK)


