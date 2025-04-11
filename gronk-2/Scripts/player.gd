extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var level_manager: Node = %LevelManager
@onready var jump: AudioStreamPlayer2D = $Audio/Jump
@onready var die: AudioStreamPlayer2D = $Audio/Die
@onready var timer: Timer = $Timer

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var max_health := 100
var current_health := max_health

# health stuff
func take_damage(amount: int = 1) -> void:
	current_health -= amount
	current_health = max(current_health, 0)
	die.play() # play sound
	velocity.y = JUMP_VELOCITY / 1.5 # bounce player on hit
	print("Player got hit! Current health: ", current_health)
	
	if current_health <= 0:
		player_killed()

func player_killed():
	print("You died!")
	collision_shape_2d.queue_free()
	Engine.time_scale = 0.5
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()

# movement stuff
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump.play()
	
	# get the input directions -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else: 
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
