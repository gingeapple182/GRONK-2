extends Area2D

@onready var level_manager: Node = %LevelManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(_body: Node2D) -> void:
	level_manager.add_point()
	animation_player.play("Pickup")
