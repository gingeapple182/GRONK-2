extends Node

@export var level = 1
var level_scores = {1: 0, 2: 0}

func set_level_score(level, score):
	level_scores[level] = score
	
func get_level_score(level):
	return level_scores.get(level, 0)
	
func reset_scores():
	level_scores = {1:0, 2: 0}
