extends TileMapLayer

const ANCHO = 100
const ALTO = 100
var open_simplex_noise = FastNoiseLite.new()
const TILES = {"placeholder":1}


func _ready():
	randomize()
	open_simplex_noise.seed = randi()
	_generate_world()

func _generate_world():
	var cell_type
	for x in ANCHO:
		for y in ALTO:
			cell_type = _generate_cell_type(open_simplex_noise.get_noise_2d(float(x),float(y)))
			set_cell(Vector2i(x,y),cell_type)
func _generate_cell_type(noise_num):
	if noise_num < 0.5:
		return TILES.placeholder
		return
