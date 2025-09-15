
### Game manager
``` python
extends Node

signal GameWon
signal GameOver

var health:int 
var score:int

func _ready() -> void:
	set_data()
func set_data():
	health = 20
	score = 20000

```
### player ui
``` python
extends Node


func _ready() -> void:
	$health.max_value = GameManager.health
	
func _process(delta: float) -> void:
	update_health()
	update_score()

func update_health():
	$health.value = GameManager.health
	pass
	
func update_score():
	$score.text = str(GameManager.score)
	pass


```

### game over Script
``` python

extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.GameWon.connect(player_won)
	GameManager.GameOver.connect(player_lost)

	pass # Replace with function body.

func player_won():
	$Winning.visible = true
	$Winning/VBoxContainer/score.text = str("score: ",GameManager.score)

func player_lost():
	$Lost.visible = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_try_again_pressed() -> void:
	GameManager.set_data()
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	pass # Replace with function body.

```
### Player Script
``` python
extends CharacterBody2D


@export var bullet:PackedScene
@export var SPEED = 300.0
var can_attack: bool = true

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	pass
	
func _process(delta: float) -> void:
	shoot_bullet()
	pass

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	position.x = clamp(position.x,20, 300)

	move_and_slide()

func take_damage(damage:int):
	GameManager.health = GameManager.health - damage
	
	if(GameManager.health <= 0):
		GameManager.GameOver.emit()
		get_tree().paused = true
	pass

func shoot_bullet():
	if Input.is_action_just_pressed("Fire_Bullet") && can_attack:
		var bullets = bullet.instantiate()
		bullets.position = Vector2($"Fire Point".global_position.x,$"Fire Point".global_position.y )
		get_tree().root.add_child(bullets);
		can_attack = false
		$"Attack cooldown".start()
	pass


func _on_attack_cooldown_timeout() -> void:
	can_attack = true
	pass # Replace with function body.


```

### projectile

``` python

extends Area2D

@export var damage: int = 5
@export var speed: int


func _process(delta: float) -> void:
	position.y -= speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.

```
