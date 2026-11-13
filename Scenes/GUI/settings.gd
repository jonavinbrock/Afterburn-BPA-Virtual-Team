extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resetscore_pressed() -> void:
	pass # Replace with function body.


func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/GUI/main_menu.tscn")


func _on_music_vol_value_changed(value: float) -> void:
	pass # Replace with function body.
