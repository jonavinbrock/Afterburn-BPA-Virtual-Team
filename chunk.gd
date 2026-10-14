extends Node2D
class_name chunk

func _not_visible() -> void:
	Main.chunks.erase(self)
	queue_free()
