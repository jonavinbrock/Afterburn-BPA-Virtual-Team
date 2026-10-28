extends Control
class_name Score

var current_score: int = 0

func add_points(value: int):
	current_score += value
	emit_signal("score_changed", value)
