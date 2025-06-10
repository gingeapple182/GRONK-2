extends Area2D

# Enemy Hitbox Component
# Attach to the enemy's Area2D hitbox.
# Handles player collision, knockback, damage, and stomp logic.

@onready var timer: Timer = $Timer
@onready var die: AudioStreamPlayer2D = $Die
@export var damage: float = 25.0			# Damage dealt to player on contact
@export var jump_kill: bool = true			# If true, enemy dies when stomped
@export var damage_throw: float = 200		# Knockback force applied to player

var is_dead: bool = false
@onready var parent = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if is_dead:
		return
	if body.is_in_group("player"):
		print("Player got hit by enemy")
		# Apply knockback based on side of collision
		if body.global_position.x > global_position.x:
			print("Player entered from the RIGHT")
			body.velocity.x = damage_throw
		else:
			print("Player entered from the LEFT")
			body.velocity.x = -damage_throw
		body.take_damage(damage)

# Call this when the player stomps the enemy
func on_stomped():
	is_dead = true
	if $CollisionShape2D:
		$CollisionShape2D.disabled = true
	if parent.has_method("died") and jump_kill:
		parent.died()
	else:
		print("Enemy doesnt die")
