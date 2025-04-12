extends Area2D

@onready var timer: Timer = $Timer
@onready var die: AudioStreamPlayer2D = $Die

@export var damage: float = 0.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
