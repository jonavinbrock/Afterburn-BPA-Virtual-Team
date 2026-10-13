extends TileMapLayer

const ANCHO = 100
const ALTO = 100
var open_simplex_noise
const TILES = {"pasto":5 , "agua":0 , "tierra":6}
@onready var grilla = $TileMap

func _ready():
	randomize()
	open_simplex_noise = FastNoiseLite.new()
	open_simplex_noise.seed = randi()
	open_simplex_noise.octaves = 4.0
	open_simplex_noise.period = 256
	open_simplex_noise.persistence = 0.349
	_generate_world()

func _generate_world():
	var tipo_celda
	for x in ANCHO:
		for y in ALTO:
			tipo_celda = _generate_cell_type(open_simplex_noise.get_noise_2d(float(x),float(y)))
			grilla.set_cell(x,y,tipo_celda)
func _generate_cell_type(noise_num):
	if noise_num < 0.5:
		return TILES.pasto
	elif noise_num < 0.6 && noise_num > 0.5:
		return TILES.tierra
	else:
		return TILES.agua
