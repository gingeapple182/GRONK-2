extends Control

var final_score = 0

func _ready() -> void:
	var level_one_score = GameManager.get_level_score(1)
	var level_two_score = GameManager.get_level_score(2)
	$ScoreLabel.text = "Level one coins obtained: " + str(level_one_score) + "\nLevel two coins obtained: " +  str(level_two_score)
	#$ScoreLabel.text = "Coins collected: " + str(final_score)
	
func set_final_score(score):
	final_score = score
	
func _on_replay_button_pressed() -> void:
	GameManager.reset_scores()
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_start_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
