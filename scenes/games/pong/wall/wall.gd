extends Area2D


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D) -> void:
	other_area.direction.y = -other_area.direction.y
