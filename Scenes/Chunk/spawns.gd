extends Node2D

const DRONE_SCENE = preload("res://Scripts/Drone/enemy_drone.tscn")

@onready var spawn_points: Node2D = self

func _ready() -> void:
	spawn_enemy()
	
func spawn_enemy() -> void:
	var points = spawn_points.get_children()
	
	if points.is_empty():
		return
		
	var spawn_point = points.pick_random()
	
	var drone = DRONE_SCENE.instantiate()
	get_tree().current_scene.add_child(drone)
	
	drone.global_position = spawn_point.global_position
