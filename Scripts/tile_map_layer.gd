extends TileMapLayer

# Infinitely Scrolling TileMap Layer

func _ready() -> void:
	position.y = 0


func _process(delta: float) -> void:
	# Move the chunk downwards at a frame rate of 64px per sec
	# Generate a new chunk when the current one is out of view

	position.y -= 64 * delta
	if position.y >= 64:
		position.y = 0
		generate_chunk()

func generate_chunk() -> void:
	# Generate a new chunk of predefined tiles
	for x in range(0, 10):
		for y in range(0, 10):
			var tile_id = randi() % 2
			set_cell(Vector2i(x, y), tile_id)