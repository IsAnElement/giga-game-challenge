extends Node


signal ball_destroyed(which: int)




func emit_ball_destroyed(which: int) -> void:
	ball_destroyed.emit(which)
