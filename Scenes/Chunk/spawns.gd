extends Node2D

const DRONE_SCENE = preload("res://Scripts/Drone/enemy_drone.tscn")
@export_range(0, 100) var spawn_chance: int = 15

func _ready() -> void:
	await get_tree().process_frame


	while GlobalAtributes.points < 100:
		await get_tree().process_frame
	
	

	
	spawn_enemy()

func spawn_enemy() -> void:
	if GlobalAtributes.points < 100:
		return
	

		
	if randi_range(1,75) > spawn_chance:
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

	enemy_parent.add_child(drone)
	drone.set_deferred("global_position", spawn_point.global_position)
