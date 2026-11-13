extends Control


func _on_resetscore_pressed() -> void:
	# Open the file and read it
	var file = FileAccess.open("res://Data/data.json", FileAccess.READ)
	# Parse the string and get it as text
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	
	# Set the data, High Score, to 0
	data["High Score"] = 0
	
	# Open the file and write to it
	file = FileAccess.open("res://Data/data.json", FileAccess.WRITE)
	# Store the string and stringify the data
	file.store_string(JSON.stringify(data, "\t"))
	file.close()

func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/GUI/main_menu.tscn")


func _on_music_vol_value_changed(value: float) -> void:
	pass # Replace with function body.
