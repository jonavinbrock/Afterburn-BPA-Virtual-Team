extends CharacterBody2D

@export var scroll_speed: float = 125.0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const TILE_SIZE = 64


func _ready() -> void:
	position = position.snapped(Vector2.ONE * TILE_SIZE)
	position += Vector2.ONE * TILE_SIZE / 2

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Scroll in brochacho
	position.x += scroll_speed * delta
	
	# Up and down movement
	var inputs = {"KEY_UP": Vector2.UP, "KEY_DOWN": Vector2.DOWN}
		
func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	position += inputs[dir] * tile_size
