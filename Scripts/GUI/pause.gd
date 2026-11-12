extends CanvasLayer

func _ready() -> void:
	hide()

# Function to set a keybind to open the pause menu
#
# Unsure if I will create a button to pause. I don't see much
# need for it as this is a PC game. But we'll see. - Jonavin
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_ESCAPE:
			toggle_pause()
			get_viewport().set_input_as_handled()

# Toggle function to start the pause
func toggle_pause():
	var paused = not get_tree().paused
	get_tree().paused = paused
	visible = paused


func _on_resume_pressed() -> void:
	toggle_pause()

func _on_close_resume_pressed():
	hide()
	get_tree().paused = false

func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/GUI/main_menu.tscn")
