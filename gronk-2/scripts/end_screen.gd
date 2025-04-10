extends Control

var final_score = 0

func _ready() -> void:
	var level_intro_score = GameManager.get_level_score(0)
	var level_one_score = GameManager.get_level_score(1)
	var level_two_score = GameManager.get_level_score(2)
	$TitleCard/ScoreLabel.text = """
	Level one coins obtained: {0}
	Level two coins obtained: {1}
	""".format([level_one_score, level_two_score])
	
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
