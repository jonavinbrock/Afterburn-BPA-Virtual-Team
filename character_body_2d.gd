extends CharacterBody2D

@export var scroll_speed: float = 400.0

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	position.x += scroll_speed * delta
	
