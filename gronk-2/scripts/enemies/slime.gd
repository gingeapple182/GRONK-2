extends Node2D

# Slime Enemy Behavior
# Attach to the root node of the basic Slime enemy.
# Handles facing the player at all times.

@onready var player: Node2D = null
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D2

func _ready() -> void:
	# Find the player node in the scene tree
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	# Flip the sprite to always face the player
	if player:
		if player.position.x < global_position.x:
			animated_sprite.flip_h = true
		elif player.position.x > global_position.x:
			animated_sprite.flip_h = false
