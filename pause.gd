extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_ESCAPE:
			toggle_pause()
			get_viewport().set_input_as_handled()

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
	get_tree().change_scene_to_file("res://main_menu.tscn")
