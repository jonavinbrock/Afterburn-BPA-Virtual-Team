extends Node2D
class_name Main

const chunkOffset = 16
static var chunks:Array[chunk] = []
var chunkPackedScene = preload("res://chunk_test.tscn")
var lastX := 0.0

func _ready() -> void:
	for i in chunks:
		if is_instance_valid(i):
			i.queue_free()
	chunks.clear()
	_generation()

func _generation() -> void:
	for i in 16:
		_spawn_chunk()
		
func _spawn_chunk() -> void:
	var chunk_instance: chunk = chunkPackedScene.instantiate()
	add_child(chunk_instance)
	
	if chunks.size() != 0:
		lastX = chunks.back().global_position.x
	chunk_instance.global_position.x = lastX + chunkOffset
	chunks.append(chunk_instance)
	
	chunk_instance.chunkLScreen.connect(_spawn_chunk)
		
