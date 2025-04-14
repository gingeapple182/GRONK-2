extends Node2D

const SPEED = 40

var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		animated_sprite.play("hit")
		timer.start()
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		animated_sprite.play("hit")
		timer.start()
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta

func _on_timer_timeout() -> void:
	animated_sprite.play("run")

func died() -> void:
	animated_sprite.play("hit")
	await get_tree().create_timer(0.5).timeout
	queue_free()
