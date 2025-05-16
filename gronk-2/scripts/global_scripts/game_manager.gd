extends Node
var pause_menu_scene = preload("res://scenes/menu/pause_menu.tscn")
var pause_menu: Control
enum PauseMode { INHERIT, STOP, PROCESS }


@export var mute_when_unfocussed := true
@export var level = 0
var level_scores = {0: 0, 1: 0, 2: 0}
@export var playerHealth = 100
# 0 = start : 1 = lvl 1 pause : 2 = lvl 2 pause : 3 = lvl 3 pause
@export var gameLocation = 0

func _ready():
	pass
	#pause_menu = pause_menu_scene.instantiate()
	#get_tree().current_scene.add_child(pause_menu)
	#pause_menu.pause_mode = PauseMode.PROCESS
	#pause_menu.visible = false


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			resume_game()
		else:
			pause_game()

func pause_game():
	#get_tree().paused = true
	#0pause_menu.visible = true
	pass;

func resume_game():
	#get_tree().paused = false
	#pause_menu.visible = false
	pass;
	
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
