extends CharacterBody2D
class_name Player

# Variables
@export var scroll_speed: float = 125.0
@export var animation_speed: float = 3.0
@export var moving: bool = false
@onready var ray: RayCast2D = $RayCast2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var state_machine = $StateMachine
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const TILE_SIZE = 12

var inputs = {"up": Vector2.UP, "down": Vector2.DOWN}
var max_negative_y = -32
var max_positive_y = 32

func _ready() -> void:
	z_index = 2
	GlobalAtributes.player = self

func _physics_process(delta: float) -> void:
	# Camera that sets itself equal to the player x pos
	get_parent().find_child("Camera2D").position.x = self.position.x
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite.play("Idle")
		
	# Camera Scroll for the player to create the effect of the player
	# skating into the scene
	position.x += scroll_speed * delta
	check_enemy_collision()
	scroll_speed += 0.001
	
# Function that handles input to move the player up or down
func _unhandled_input(event: InputEvent) -> void:
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

# Function that handles how far the player moves up and down.
# This allows you to move to one lane instead of slowly moving up.
func move(dir):
	var movement = inputs[dir] * TILE_SIZE
	var target_position = position + movement
	
	ray.target_position = inputs[dir] * TILE_SIZE
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] * TILE_SIZE, 1.0 / animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
		
	if target_position.y <= max_positive_y:
		return
	if target_position.y >= max_negative_y:
		return

# Collision check for enemies, obstacles, etc.
func check_enemy_collision() -> void:
	var space = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()

	query.shape = $CollisionShape2D.shape
	query.transform = $CollisionShape2D.global_transform
	query.collision_mask = collision_mask
	query.exclude = [get_rid()]

	var collisions = space.intersect_shape(query)

	for result in collisions:
		var collider = result["collider"]

		if collider.is_in_group("enemies"):
			die()
			return

# Return to the main menu on death. Will be switched out for a game over
# screen when the time comes. 
func die():
	# Open file as READ, important that you only do it as READ.
	var file = FileAccess.open("res://Data/data.json", FileAccess.READ)
	# Turns the file into a proper dictionary to be edited.
	var data = JSON.parse_string(file.get_as_text())
	# !!!ALWAYS close a file after you're done reading/writing it.
	file.close()
	
	if (GlobalAtributes.points > data["High Score"]):
		
		# Edit the data so we can store the high score.
		data["High Score"] = GlobalAtributes.points
		
		
		
		# Save the now edited data as a string,
		var string = JSON.stringify(data, "\t")
		
		# Re-open the file as WRITE so that we can edit it.
		file = FileAccess.open("res://Data/data.json", FileAccess.WRITE)
		# Now that we can edit it, we replace the information with the string version
		# of the edited data.
		file.store_string(string)
		# !!!ALWAYS close a file after you're done reading/writing it.
		file.close()
	
	# var data = JSON.parse_string(file.get_as_text())
	# print(data["High Score"])
	print(GlobalAtributes.points)
	get_tree().change_scene_to_file("res://Scenes/GUI/main_menu.tscn")

# Test function that is just code bloat
func _on_tree_exited() -> void:
	print("Die")
	
