extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = load("res://Scripts/870940__innov8_music__retro-house-loop-130bpm-8bars-dmin-korg-m1-roland-909.wav")
	audio_player.loop = true
	audio_player.play()
