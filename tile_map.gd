extends TileMap

func _populate_cell(pos: Vector2i, tile: Vector2i) -> void:
  var player_position = _get_player_position()

  for i in range(-CHUNK_SIZE * 2, CHUNK_SIZE * 2):
	for j in range(-CHUNK_SIZE * 2, CHUNK_SIZE * 2):
	  var pos = player_position + Vector2i(i, j)
	  if _is_empty(pos):
		_populate_cell(pos, _pick_random_tile()) 

func _populate_cell(pos: Vector2i, tile: Vector2i) -> void:
  tilemap.set_cell.call_deferred(
	TERRAIN_LAYER_ID, pos, TERRAIN_SOURCE_ID, tile, ALTERNATIVE_TILE_ID
  )

func _on_exited_chunk():
  visibility_notifier.global_position = (
	get_tree().get_first_node_in_group(Player.GROUP).global_position
  )

  var thread = Thread.new()
  thread.start(func(): _populate_terrain())
  thread.wait_to_finish()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
