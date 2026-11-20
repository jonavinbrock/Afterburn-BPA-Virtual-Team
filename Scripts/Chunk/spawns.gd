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
@export_range(0, 100) var drone_chance: int = 50
@export_range(0, 100) var car_chance: int = 20
@export_range(0, 100) var crystal_chance: int = 30

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

	var enemy_parent = get_tree().current_scene
	var crystal_parent = get_tree().current_scene
	var car_parent = get_tree().current_scene
	var parent_node = get_tree().current_scene
	
	if !enemy_parent:
		return
	
	
	var total_weight: int = drone_chance + crystal_chance + car_chance
	if total_weight <= 0:
		return
	
	
	var roll_spawn: int = randi_range(1, total_weight)
	var scene_to_spawn: PackedScene = null


	if roll_spawn <= drone_chance:
		scene_to_spawn = DRONE_SCENE
	elif roll_spawn <= drone_chance + crystal_chance:
		scene_to_spawn = CRYSTAL_SCENE
	else:
		# Pick one random car color from the array
		scene_to_spawn = CAR_SCENES.pick_random()
	
	# If there is a scene to spawn, set the spawn point
	# and instance and add it to the current scene (being the main game)
	if scene_to_spawn:
		var spawn_point: Marker2D = points.pick_random()
		var instance = scene_to_spawn.instantiate()
		
		parent_node.add_child.call_deferred(instance)
		instance.z_index = 1
		instance.global_position = spawn_point.global_position
