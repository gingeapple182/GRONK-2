extends Node

# Global.gd
# This autoload is for storing global variables, references, and utility functions.
# Use this for things like player stats, game state, or references to important nodes.

# Example usage:
#	Global.player_health = 100
#	Global.level_completed = false

var player_health: int = 100
var level_completed: bool = false

# Add any global utility functions here
func reset_game():
	# Reset global state for a new game
	player_health = 100
	level_completed = false
