extends Area2D

@onready var timer: Timer = $Timer
@onready var die: AudioStreamPlayer2D = $Die
@export var damage: float = 25.0
@export var jump_kill := true
@export var damage_throw := 200

var is_dead := false
@onready var parent = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if is_dead:
		return
	if body.is_in_group("player"):
		print("Player got hit by enemy")
		if body.global_position.x > global_position.x:
			print("Player entered from the RIGHT")
			body.velocity.x = damage_throw
		else:
			print("Player entered from the LEFT")
			body.velocity.x = -damage_throw
		body.take_damage(damage)

func on_stomped():
	is_dead = true
	if $CollisionShape2D:
		$CollisionShape2D.disabled = true
	if get_parent().has_method("died") and jump_kill:
		get_parent().died()
	else:
		print("Enemy doesnt die")
