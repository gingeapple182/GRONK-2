extends Node2D

const SPEED = 40

var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

func _process(delta: float) -> void:
	# Patrol logic: turn around when hitting a wall/object
	if ray_cast_right.is_colliding():
		animated_sprite.play("hit")
		timer.start()
		direction = -1
		animated_sprite.flip_h = true
	elif ray_cast_left.is_colliding():
		animated_sprite.play("hit")
		timer.start()
		direction = 1
		animated_sprite.flip_h = false
	# Move in the current direction
	position.x += direction * SPEED * delta

func _on_timer_timeout() -> void:
	# Resume running animation after hit
	animated_sprite.play("run")

func died() -> void:
	# Play hit animation, then remove the enemy after a short delay
	animated_sprite.play("hit")
	await get_tree().create_timer(0.5).timeout
	queue_free()
