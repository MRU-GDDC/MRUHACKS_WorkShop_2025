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
