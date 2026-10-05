extends CharacterBody2D

@export var player: CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -400.0
const grid_size = 48


func die():
	pass
	

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if (Input.is_action_just_pressed("ui_left")):
		position.x -= grid_size
	if (Input.is_action_just_pressed("ui_right")):
		position.x += grid_size
	if (Input.is_action_just_pressed("ui_accept")):
		position.y -= grid_size
	move_and_slide()
