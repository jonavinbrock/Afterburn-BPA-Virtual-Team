extends Node2D
class_name chunk

signal chunkLScreen

func _not_visible() -> void:
	Main.chunks.erase(self)
	chunkLScreen.emit()
	queue_free()
