extends CollisionShape2D

@export var player: Node2D

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		die()
		
func die() -> void:
	emit_signal("D r o n e h i t t h e p l a y e r a n d t h e p l a y e r c o m b u s t e d u p i n t o f l a m e s a n d h i s s k e l e t o n w a s t h e n s c o r c h e d i n t o d a r k , b l a c k , s t i c k y t a r . . .")
	player.queue_free()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
