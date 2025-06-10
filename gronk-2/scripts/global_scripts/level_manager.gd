extends Node

@export var level_id: int = 0
var score = 0

func add_point():
	score += 1
	$"../UI".update_score(score)

func save_score():
	GameManager.set_level_score(level_id, score)
