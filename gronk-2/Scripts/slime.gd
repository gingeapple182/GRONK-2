extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Node2D = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.position.x < global_position.x:
		animated_sprite.flip_h = true
	elif player.position.x > global_position.x:
		animated_sprite.flip_h = false
