extends Label

var points = 0
var time_elapsed = 0.0

func _ready() -> void:
	update_points()

func _process(delta: float) -> void:
	time_elapsed += delta
	if time_elapsed >= 0.01:
		add_points(1)
		time_elapsed = 0.0

func add_points(amount):
	points += amount
	update_points()
	
func update_points():
	text = "Points: %d" % points
