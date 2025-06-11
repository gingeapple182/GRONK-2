extends Node

# SceneChanger.gd
# This autoload handles scene transitions and switching.
# Use this to change scenes with optional transitions (fade, etc).

# Example usage:
#	SceneChanger.change_scene("res://scenes/levels/level_one.tscn")

var transition_in_progress: bool = false

func change_scene(path: String):
	# Change to a new scene, optionally add transition effects here
	if transition_in_progress:
		return
	transition_in_progress = true
	get_tree().change_scene_to_file(path)
	transition_in_progress = false
