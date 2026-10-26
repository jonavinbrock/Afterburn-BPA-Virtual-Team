extends Area2D

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("area_entered", _on_body_entered)
	
func _on_body_entered(body):
	if body.name == "Drone":
		perishFromThisSorrowfulRealm()
		
func _on_area_entered(area):
	if area.is_in_group("enemies"):
		perishFromThisSorrowfulRealm()
		
func perishFromThisSorrowfulRealm():
	queue_free()
