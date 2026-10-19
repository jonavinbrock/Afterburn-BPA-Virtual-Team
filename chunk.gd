extends Node2D
class_name chunk

signal chunkLScreen

#@export var scroll_speed: float = 1.0
#
#func _process(delta: float) -> void:
	#position.x += scroll_speed * delta

func _not_visible() -> void:
	Main.chunks.erase(self)
	chunkLScreen.emit()
	queue_free()
