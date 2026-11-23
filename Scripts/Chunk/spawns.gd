extends Node2D

# Scenes for the drone enemy, crystal, and cars.
const DRONE_SCENE = preload("res://Scenes/Drone/enemy_drone.tscn")
const CRYSTAL_SCENE = preload("res://Assets/Crystal/crystal.tscn")
const CAR_SCENES: Array[PackedScene] = [
	preload("res://Assets/Cars/green_big_car.tscn"),
	preload("res://Assets/Cars/purple_big_car.tscn"),
	preload("res://Assets/Cars/pink_big_car.tscn"),
	preload("res://Assets/Cars/black_small_car.tscn"),
	preload("res://Assets/Cars/red_small_car.tscn"),
	preload("res://Assets/Cars/yellow_small_car.tscn")
]

@export_group("Spawn Chances")
@export_range(0, 100) var drone_chance: int = 15
@export_range(0, 100) var car_chance: int = 30
@export_range(0, 100) var crystal_chance: int = 5

# Spawn the enemy if the scrore is above the given int.
func _ready() -> void:
	if GlobalAtributes.score > 100:
		spawn_enemy()

# Function to spawn the enemy using arrays and                                                                                                                                              spawn points. 
func spawn_enemy() -> void:
	#if randi_range(1,100) > overall_spawn_chance:
		#return

	var points: Array[Marker2D] = []
	
	for child in get_children():
		if child is Marker2D:
			points.append(child)

	if points.is_empty():
		return

	var parent_node = get_tree().current_scene
	
	if !parent_node:
		return
	
	if randi_range(1, 100) <= crystal_chance:
		spawn_object(CRYSTAL_SCENE, points, parent_node)
	
	if randi_range(1, 100) <= car_chance:
		var random_car: PackedScene = CAR_SCENES.pick_random()
		spawn_object(random_car, points, parent_node)

	if randi_range(1, 100) <= drone_chance:
		spawn_object(DRONE_SCENE, points, parent_node)
		
func spawn_object(scene: PackedScene, points: Array[Marker2D], parent_node: Node) -> void:
	if points.size() == 0:
		return

	var random_index = randi_range(0, points.size() - 1)
	var spawn_point: Marker2D = points[random_index]

	points.remove_at(random_index)

	var instance = scene.instantiate()
	parent_node.add_child(instance)
	instance.global_position = spawn_point.global_position
	instance.z_index = 1
