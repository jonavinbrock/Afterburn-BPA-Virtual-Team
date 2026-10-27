extends CharacterBody2D

const dronePackedScene = preload("res://Scripts/Drone/enemy_drone.tscn")

var scrollSpeed = -5.0
var startingPosition = 256.0
var endingPosition = 20.0

func _ready() -> void:
	global_position.x = startingPosition
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	position.x += scrollSpeed * delta
	
	if position.x <= endingPosition:
		spawnDrone()
		
func spawnDrone() -> void:
	var drone = dronePackedScene.instantiate()
	get_parent().add_child(drone)
	
	drone.global_position = Vector2(global_position.x, 50.0)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
