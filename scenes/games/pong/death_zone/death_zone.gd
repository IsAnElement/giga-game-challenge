extends Area2D

@export var which_player: int

func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D) -> void:
	GameEvents.emit_ball_destroyed(which_player)
