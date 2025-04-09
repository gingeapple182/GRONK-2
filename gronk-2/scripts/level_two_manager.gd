extends Node

@onready var score_label: Label = $ScoreLabel

var score = 0

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " of 30 coins"

func save_score():
	GameManager.set_level_score(3, score)
