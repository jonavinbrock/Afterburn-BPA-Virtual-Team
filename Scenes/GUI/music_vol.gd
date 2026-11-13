extends HSlider

var Song = AudioServer.get_bus_index("jeff")


func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(Song, value)
	
	if value == -30:
		AudioServer.set_bus_mute(Song,true)
	else:
		AudioServer.set_bus_mute(Song,false)
