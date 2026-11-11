extends Node2D

func _ready() -> void:
	var mp = $MediaPlayer2D
	var hsl = $HSlider
	mp.player_state_changed.connect(hsl._on_player_state_changed)
	
	get_tree().paused = false
	
	var file = FileAccess.open("res://Data/data.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	
	find_child("Highscore").text = "High Score: " + str(int(data["High Score"]))
	

# Press play to start the main scene
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")


func _on_unlocks_pressed() -> void:
	pass # Likely to not ever be finished


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/GUI/settings.tscn")

# Press exit to exit the game
func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	pass # To Be Done
