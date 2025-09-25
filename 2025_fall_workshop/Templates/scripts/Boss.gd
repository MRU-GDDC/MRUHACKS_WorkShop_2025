extends Area2D

@export var health:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	position = Vector2(0,30)
	var tween = get_tree().create_tween()
	tween.set_loops(0)
	tween.tween_property($".","position",Vector2(300,70),randf_range(3,4))
	tween.chain().tween_property($".","position",Vector2(20,70),randf_range(3,4))
	pass # Replace with function body.
func take_damage(damage: int):
	health = health  - damage
	if health <= 0:
		#GameManager.GameWon.emit()
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
