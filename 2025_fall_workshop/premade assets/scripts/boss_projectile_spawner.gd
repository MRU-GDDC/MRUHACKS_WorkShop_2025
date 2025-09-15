extends Node2D

@export var boss_projectile: PackedScene
var start
var end
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start = 30
	end = 300
	pass # Replace with function body.




func _on_timer_timeout() -> void:
	var bullet = boss_projectile.instantiate()
	bullet.position = Vector2(randf_range(start, end), - 30 )
	add_child(bullet)
