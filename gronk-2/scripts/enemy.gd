extends Area2D

@onready var timer: Timer = $Timer
@onready var die: AudioStreamPlayer2D = $Die
@export var damage: float = 0.0
@export var jump_kill := true
@export var damage_throw := 200
@export var stomp_margin := 6.0

var parent = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player_y = body.global_position.y
		var enemy_y = global_position.y
		var delta = body.global_position - get_parent().global_position
		print("delta.y =", delta.y)
		if player_y < enemy_y - stomp_margin:
		#if delta.y < -10:
			print("Player jumped on enemy")
			body.velocity.y = -damage_throw
			if parent.has_method("died") and jump_kill:
				parent.died()
			else:
				print("Enemy doesnt die")
#			get_parent().died()
		else:
			print("Player got hit by enemy")
			if body.global_position.x > global_position.x:
			#if delta.x > 0:
				print("Player entered from the RIGHT")
				body.velocity.x = damage_throw
			else:
				print("Player entered from the LEFT")
				body.velocity.x = -damage_throw
			body.take_damage(damage)
