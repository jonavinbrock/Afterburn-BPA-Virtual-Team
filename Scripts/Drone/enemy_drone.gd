extends CharacterBody2D

# Variables
const dronePackedScene = preload("res://Scenes/Drone/enemy_drone.tscn")
var scrollSpeed = -5.0
var startingPosition = 256.0
var endingPosition = 20.0
@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	global_position.x += scrollSpeed * delta
	animated_sprite.play("Drone")
	if global_position.x <= endingPosition:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
