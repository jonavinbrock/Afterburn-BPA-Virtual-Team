extends Node2D

const DRONE_SCENE = preload("res://Scripts/Drone/enemy_drone.tscn")

@export_range(0, 100) var spawn_chance: int = 15

func _ready() -> void:
	await get_tree().process_frame

	var score = get_tree().get_first_node_in_group("score")

	while score == null or score.points < 400:
		await get_tree().process_frame
		score = get_tree().get_first_node_in_group("score")
		
	spawn_enemy()

func spawn_enemy() -> void:
	var score = get_tree().get_first_node_in_group("score")
	
	if score == null or score.points < 400:
		return
		
	if randi_range(1, 100) > spawn_chance:
		return
	
	var points: Array[Marker2D] = []

	for child in get_children():
		if child is Marker2D:
			points.append(child)

	if points.is_empty():
		return

	var enemy_parent = get_tree().current_scene
	if enemy_parent == null:
		return

	var spawn_point: Marker2D = points.pick_random()
	var drone = DRONE_SCENE.instantiate()

	enemy_parent.add_child.call_deferred(drone)
	drone.set_deferred("global_position", spawn_point.global_position)
