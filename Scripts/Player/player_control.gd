extends CharacterBody2D
class_name Player



# Variables
@export var scroll_speed: float = 125.0
@export var scroll_acceleration: float = 0.6
@export var lane_speed: float = 200.0
@export var dash_speed: float = 400.0
@export var dash_time: float = 0.15

var TILE_SIZE = 12
var MIN_Y = -32
var MAX_Y = 32

@onready var animated_sprite = $AnimatedSprite2D

var target_y: float
var dash_timer: float = 0.0

func _ready() -> void:
	z_index = 2
	target_y = position.y
	GlobalAtributes.player = self

func _physics_process(delta: float) -> void:
	scroll_speed += scroll_acceleration * delta
	
	# Camera that sets itself equal to the player x pos
	get_parent().find_child("Camera2D").position.x = self.position.x
	
	velocity.x = scroll_speed
	if dash_timer > 0.0:
		dash_timer -= delta
		velocity.x += dash_speed
	elif Input.is_action_just_pressed("Dash"):
		dash_timer = dash_time

	var diff := target_y - position.y
	velocity.y = clampf(diff / delta, -lane_speed, lane_speed)

	move_and_slide()

	for i in get_slide_collision_count():
		var normal := get_slide_collision(i).get_normal()
		if absf(normal.y) > 0.5:
			target_y = position.y

	check_enemy_collision()
	
func _process(delta: float) -> void:
	move_and_slide()	
	
# Function that handles input to move the player up or down
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		change_lane(-1)
	elif event.is_action_pressed("down"):
		change_lane(1)

func change_lane(dir: int) -> void:
	var new_y: float = target_y + dir * TILE_SIZE
	if new_y < MIN_Y or new_y > MAX_Y:
		return
	if test_move(global_transform, Vector2(0, dir * TILE_SIZE)):
		return
	target_y = new_y
	
# Function that handles how far the player moves up and down.
# This allows you to move to one lane instead of slowly moving up.
#func move(dir):
	#var movement = inputs[dir] * TILE_SIZE
	#var target_position = position + movement
	#
	#var top_sidewalk = -160
	#var bottom_sidewalk = 160
	#
	##if target_position != target_position.clamp(Vector2(-160, -30), Vector2(160, 23)):
		##return
	#
	#ray.target_position = inputs[dir] * TILE_SIZE
	#ray.force_raycast_update()
	#
	#if !ray.is_colliding():
		#var tween = create_tween()
		#tween.tween_property(self, "position",
			#position + inputs[dir] * TILE_SIZE, 1.0 / animation_speed).set_trans(Tween.TRANS_SINE)
		#moving = true
		#await tween.finished
		#moving = false
		#
	#if target_position.y <= max_positive_y:
		#return
	#if target_position.y >= max_negative_y:
		#return

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
	
