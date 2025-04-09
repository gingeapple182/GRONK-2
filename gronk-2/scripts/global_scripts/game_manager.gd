extends Node

@export var mute_when_unfocussed := true
@export var level = 0
var level_scores = {0: 0, 1: 0, 2: 0}
@export var playerHealth = 100

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT and mute_when_unfocussed:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	elif what == NOTIFICATION_WM_WINDOW_FOCUS_IN:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		
func set_level_score(level, score):
	level_scores[level] = score
	
func get_level_score(level):
	return level_scores.get(level, 0)
	
func reset_scores():
	level_scores = {0: 0, 1: 0, 2: 0}
