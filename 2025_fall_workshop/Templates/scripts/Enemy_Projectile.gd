extends Area2D

@export var damage: int = 5
@export var speed: int  = -200


func _process(delta: float) -> void:
	position.y -= speed * delta




func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
