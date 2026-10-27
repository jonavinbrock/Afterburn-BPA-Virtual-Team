extends Node2D

const DRONE_SCENE = preload("res://Scripts/Drone/enemy_drone.tscn")

@export_range(0, 100) var spawn_chance: int = 10
@onready var timer: Timer = $Timer

func _ready() -> void:
	spawn_enemy()


func spawn_enemy() -> void:
	if randi_range(1, 100) > spawn_chance:
		return
	
	var points: Array[Node] = []
	for child in get_children():
		if child is Marker2D:
			points.append(child)
	
	if points.is_empty():
		return
	
	var enemy_count = randi_range(0, min(2, points.size()))
	
	points.shuffle()
	
	var enemy_parent = get_tree().current_scene
	var score := get_tree().get_first_node_in_group("score")
	
	if score:
		if not score.points:
			return
		var score_number = score.points
		if score_number > 400:
			for i in range(enemy_count):
				var spawn_point = points[i]
				var drone = DRONE_SCENE.instantiate()
				print("spawned")
				enemy_parent.add_child(drone)
				drone.global_position = spawn_point.global_position
		else:return


func _on_timer_timeout() -> void:
	pass # Replace with function body.
