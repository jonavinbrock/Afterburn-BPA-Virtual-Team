extends Node2D
class_name Main

const chunkOffset = 16
static var chunks: Array[chunk] = []

var chunkPackedScene = preload("res://Scenes/Chunk/chunk.tscn")
var lastX := 0.0

func _ready() -> void:
	for i in chunks:
		if is_instance_valid(i):
			i.queue_free()

	chunks.clear()
	_generation()

func _generation() -> void:
	for i in range(16):
		_spawn_chunk()

func _spawn_chunk() -> void:
	var chunk_instance: chunk = chunkPackedScene.instantiate()

	if chunks.size() != 0:
		lastX = chunks.back().global_position.x

	chunk_instance.global_position.x = lastX + chunkOffset
	add_child(chunk_instance)
	chunks.append(chunk_instance)

	var spawns = chunk_instance.get_node_or_null("Spawns")

	if spawns != null:
		spawns.spawn_enemy()
	else:
		print("ERROR: Spawns node missing in ", chunk_instance.name)

	chunk_instance.chunkLScreen.connect(_spawn_chunk)
