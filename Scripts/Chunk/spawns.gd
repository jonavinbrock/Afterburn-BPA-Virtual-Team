extends Node2D

const DRONE_SCENE = preload("res://Scenes/Drone/enemy_drone.tscn")
const CRYSTAL_SCENE = preload("res://Assets/Crystal/crystal.tscn")

const GREEN_CAR = preload("res://Assets/Cars/green_big_car.tscn")
const PURPLE_CAR = preload("res://Assets/Cars/purple_big_car.tscn")
const PINK_CAR = preload("res://Assets/Cars/pink_big_car.tscn")
const BLACK_CAR = preload("res://Assets/Cars/black_small_car.tscn")
const RED_CAR = preload("res://Assets/Cars/red_small_car.tscn")
const YELLOW_CAR = preload("res://Assets/Cars/yellow_small_car.tscn")

@export_range(0, 100) var spawn_chance: int = 0

# Spawn the enemy if the scrore is above the given int.
func _ready() -> void:
	if GlobalAtributes.score < 100:
		spawn_enemy()

# Function to spawn the enemy using arrays and                                                                                                                                              spawn points. 
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
	var crystal_parent = get_tree().current_scene
	var car_parent = get_tree().current_scene
	
	if !enemy_parent:
		return

	var spawn_point: Marker2D = points.pick_random()
	
	var drone = DRONE_SCENE.instantiate()
	var crystal = CRYSTAL_SCENE.instantiate()
	
	var green_car = GREEN_CAR.instantiate()
	var purple_car = PURPLE_CAR.instantiate()
	var pink_car = PINK_CAR.instantiate()
	var black_car = BLACK_CAR.instantiate()
	var red_car = RED_CAR.instantiate()
	var yellow_car = YELLOW_CAR.instantiate()
	

	enemy_parent.add_child.call_deferred(drone)
	drone.z_index = 1
	drone.global_position = spawn_point.global_position
	
	crystal_parent.add_child.call_deferred(crystal)
	crystal.z_index = 1
	crystal.global_position = spawn_point.global_position
	
	car_parent.add_child.call_deferred(green_car)
	green_car.z_index = 1
	green_car.global_position = spawn_point.global_position
	
	car_parent.add_child.call_deferred(purple_car)
	purple_car.z_index = 1
	purple_car.global_position = spawn_point.global_position
	
	car_parent.add_child.call_deferred(pink_car)
	pink_car.z_index = 1
	pink_car.global_position = spawn_point.global_position
	
	car_parent.add_child.call_deferred(black_car)
	black_car.z_index = 1
	black_car.global_position = spawn_point.global_position
	
	car_parent.add_child.call_deferred(red_car)
	red_car.z_index = 1
	red_car.global_position = spawn_point.global_position
	
	car_parent.add_child.call_deferred(yellow_car)
	yellow_car.z_index = 1
	yellow_car.global_position = spawn_point.global_position
	
