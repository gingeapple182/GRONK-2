extends Node

@onready var score_label: Label = $ScoreLabel

var score = 0

func add_point():
	score += 1
	$"../UI".update_score(score) 

func save_score():
	GameManager.set_level_score(2, score)
