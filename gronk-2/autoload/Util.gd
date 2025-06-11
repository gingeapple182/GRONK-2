extends Node

# Util.gd
# This autoload is for enums, constants, and helper functions used throughout the project.
# Keeps your code DRY and consistent.

# Example usage:
#	if state == Util.PLAYER_STATE.JUMP:
#		...

enum PLAYER_STATE { IDLE, RUN, JUMP, FALL, HURT, DEAD }
enum ENEMY_TYPE { SLIME, DINO_RED }

const COIN_VALUE = 1
const MAX_HEALTH = 100

# Example helper function
func clamp_health(value: int) -> int:
	return clamp(value, 0, MAX_HEALTH)
