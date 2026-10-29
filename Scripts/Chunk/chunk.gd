extends Node2D
class_name chunk

signal chunkLScreen
signal timeout

const TIME_PERIOD = 1

var time = 0

func _process(delta: float) -> void:
	time += delta
	if time > TIME_PERIOD:
		emit_signal("timeout")
		time = 0

func _not_visible() -> void:
	Main.chunks.erase(self)
	chunkLScreen.emit()
	queue_free()
