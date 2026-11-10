extends Node2D

const DRONE_SCENE = preload("res://Scenes/Drone/enemy_drone.tscn")
@export_range(0, 100) var spawn_chance: int = 0

# Spawn the enemy if the scrore is above the given int.
func _ready() -> void:
	if GlobalAtributes.score < 100:
		spawn_enemy()

# Function to spawn the enemy using arrays and spawn points. 
func spawn_enemy() -> void:
	if randi_range(0,200) > spawn_chance:
		return

	var points: Array[Marker2D] = []
	
	for child in get_children():
		if child is Marker2D:
			points.append(child)

	if points.is_empty():
		return

	var enemy_parent = get_tree().current_scene
	
	if !enemy_parent:
		return

	var spawn_point: Marker2D = points.pick_random()
	var drone = DRONE_SCENE.instantiate()

	enemy_parent.add_child.call_deferred(drone)
	drone.z_index =1
	drone.global_position = spawn_point.global_position
