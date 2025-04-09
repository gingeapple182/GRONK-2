extends Control

var final_score = 0

func _ready() -> void:
	var level_intro_score = GameManager.get_level_score(1)
	var level_one_score = GameManager.get_level_score(2)
	var level_two_score = GameManager.get_level_score(3)
	$ScoreLabel.text = (
		"Level one coins obtained: " + str(level_one_score) + "\n" + 
		"Level two coins obtained: " + str(level_two_score) 
	)
	
func set_final_score(score):
	final_score = score
	
func _on_replay_button_pressed() -> void:
	GameManager.reset_scores()
	get_tree().change_scene_to_file("res://scenes/level_intro.tscn")

func _on_start_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")

func _on_button_exit_pressed() -> void:
	print("Exit game pressed")
	get_tree().quit()
