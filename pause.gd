extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_Pause_Unpause_pressed() -> void:
	get_tree().paused = true
	show()

func _on_close_Pause_Unpause_pressed():
	hide()
	get_tree().paused = false

func _on_Return_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
