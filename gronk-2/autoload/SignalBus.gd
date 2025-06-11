extends Node

# SignalBus.gd
# This autoload acts as a global signal hub for decoupled communication.
# Use this to emit and connect signals between unrelated scripts.

# Example usage:
#	SignalBus.connect("enemy_died", self, "_on_enemy_died")
#	SignalBus.emit_signal("enemy_died", enemy_ref)

signal enemy_died(enemy)
signal coin_collected(amount)
signal player_hurt(damage)
signal level_completed()

# Add more signals as needed for your game events
