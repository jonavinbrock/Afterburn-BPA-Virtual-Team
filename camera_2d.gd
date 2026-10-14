extends Camera2D

@export var move_speed: float = 200.0

func _physics_process(delta):
	var dir = Input.get_axis("left", "right")
	global_position.x += dir * move_speed * delta
