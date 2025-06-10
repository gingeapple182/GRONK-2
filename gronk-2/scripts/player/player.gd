extends CharacterBody2D

# Signals for key events
signal jumped
signal hurt
signal died
signal collected_coin
signal stomped_enemy

# Node references
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var level_manager: Node = %LevelManager
@onready var jump: AudioStreamPlayer2D = $Audio/Jump
@onready var hurtSound: AudioStreamPlayer2D = $Audio/Hurt
@onready var timer: Timer = $Timer
@onready var ui = $"../../UI"

# Player constants and variables
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const AIR_SPEED = 70.0
const HURT_DURATION := 0.5
const FLASH_INTERVAL := 0.1
const COYOTE_TIME := 0.15
const JUMP_BUFFER_TIME := 0.15
const DASH_SPEED := 350.0
const DASH_TIME := 0.18
const DASH_COOLDOWN := 0.4

var max_health := 100.0
var current_health := max_health
var hurt_time := 0.0
var flash_timer := 0.0
var coyote_timer := 0.0
var jump_buffer_timer := 0.0
var dash_timer := 0.0
var dash_cooldown := 0.0
var dash_direction := 1
var dash_in_air := false
var facing_left := false
var jumps_remaining : int = GameManager.max_jumps

# State machine setup
enum PlayerState { IDLE, RUN, JUMP, FALL, HURT, DEAD, DASH }
var state = PlayerState.IDLE

func _ready() -> void:
	pass

func handle_input():
	var direction = Input.get_axis("move_left", "move_right")
	var jump_pressed = Input.is_action_just_pressed("jump")
	var dash_pressed = Input.is_action_just_pressed("dash")
	return [direction, jump_pressed, dash_pressed]

# --- STATE MACHINE ---

func _physics_process(delta: float) -> void:
	# Decrease hurt time
	if hurt_time > 0:
		hurt_time -= delta
		# Flash sprite while invincible
		flash_timer -= delta
		if flash_timer <= 0.0:
			flash_timer = FLASH_INTERVAL
			animated_sprite.visible = not animated_sprite.visible
	else:
		animated_sprite.visible = true

	# Dash cooldown timer
	if dash_cooldown > 0.0:
		dash_cooldown -= delta

	# Apply gravity (not during dash)
	if not is_on_floor() and state != PlayerState.DASH:
		velocity += get_gravity() * delta

	var input = handle_input()
	var direction = input[0]
	var jump_pressed = input[1]
	var dash_pressed = input[2]

	# Update coyote timer
	if is_on_floor():
		coyote_timer = COYOTE_TIME
		jumps_remaining = GameManager.max_jumps
	else:
		coyote_timer -= delta

	# Update jump buffer timer
	if jump_pressed:
		jump_buffer_timer = JUMP_BUFFER_TIME
	else:
		jump_buffer_timer -= delta

	match state:
		PlayerState.IDLE:
			state_idle(direction, dash_pressed)
		PlayerState.RUN:
			state_run(direction, dash_pressed)
		PlayerState.JUMP:
			state_jump(direction, dash_pressed)
		PlayerState.FALL:
			state_fall(direction, dash_pressed)
		PlayerState.HURT:
			state_hurt()
		PlayerState.DEAD:
			state_dead()
		PlayerState.DASH:
			state_dash(jump_pressed)

	move_and_slide()

# --- STATE LOGIC FUNCTIONS ---

func state_idle(direction, dash_pressed):
	if jump_buffer_timer > 0.0 and coyote_timer > 0.0:
		velocity.y = JUMP_VELOCITY
		jump.play()
		emit_signal("jumped")
		set_state(PlayerState.JUMP)
		jump_buffer_timer = 0.0
		jumps_remaining -= 1
	elif dash_pressed and dash_cooldown <= 0.0:
		start_dash()
	elif direction != 0:
		set_state(PlayerState.RUN)
	velocity.x = move_toward(velocity.x, 0, SPEED)
	# Always face the last direction moved
	animated_sprite.flip_h = facing_left

func state_run(direction, dash_pressed):
	velocity.x = direction * SPEED
	if direction != 0:
		facing_left = direction < 0
	animated_sprite.flip_h = facing_left
	if direction == 0:
		set_state(PlayerState.IDLE)
	elif jump_buffer_timer > 0.0 and coyote_timer > 0.0:
		velocity.y = JUMP_VELOCITY
		jump.play()
		emit_signal("jumped")
		set_state(PlayerState.JUMP)
		jump_buffer_timer = 0.0
		jumps_remaining -= 1
	elif dash_pressed and dash_cooldown <= 0.0:
		start_dash()

func state_jump(direction, dash_pressed):
	velocity.x = direction * SPEED
	animated_sprite.flip_h = direction < 0
	if jump_buffer_timer > 0.0 and jumps_remaining > 0:
		velocity.y = JUMP_VELOCITY
		jump.play()
		emit_signal("jumped")
		jump_buffer_timer = 0.0
		jumps_remaining -= 1
	elif dash_pressed and dash_cooldown <= 0.0:
		start_dash()
	if velocity.y > 0:
		set_state(PlayerState.FALL)

func state_fall(direction, dash_pressed):
	velocity.x = direction * SPEED
	animated_sprite.flip_h = direction < 0
	if jump_buffer_timer > 0.0 and jumps_remaining > 0:
		velocity.y = JUMP_VELOCITY
		jump.play()
		emit_signal("jumped")
		jump_buffer_timer = 0.0
		jumps_remaining -= 1
	elif dash_pressed and dash_cooldown <= 0.0:
		start_dash()
	if is_on_floor():
		set_state(PlayerState.IDLE)

func state_dash(jump_pressed):
	# Lock direction and ignore input
	velocity.x = dash_direction * DASH_SPEED
	velocity.y = 0 if not dash_in_air else velocity.y
	dash_timer -= get_process_delta_time()
	if jump_pressed:
		set_state(PlayerState.JUMP)
		return
	if dash_timer <= 0.0:
		dash_cooldown = DASH_COOLDOWN
		if is_on_floor():
			set_state(PlayerState.IDLE)
		else:
			set_state(PlayerState.FALL)

func state_hurt():
	if hurt_time <= 0:
		if is_on_floor():
			set_state(PlayerState.IDLE)
		else:
			set_state(PlayerState.FALL)

func state_dead():
	velocity = Vector2.ZERO

# --- DASH HELPER ---

func start_dash():
	dash_direction = -1 if facing_left else 1
	dash_in_air = not is_on_floor()
	dash_timer = DASH_TIME
	set_state(PlayerState.DASH)

# --- STATE TRANSITION & ANIMATION ---

func set_state(new_state):
	if state != new_state:
		state = new_state
		enter_state(state)

func enter_state(new_state):
	match new_state:
		PlayerState.IDLE:
			animated_sprite.play("idle")
		PlayerState.RUN:
			animated_sprite.play("run")
		PlayerState.JUMP:
			animated_sprite.play("jump")
		PlayerState.FALL:
			animated_sprite.play("jump")
		PlayerState.HURT:
			animated_sprite.play("hurt")
			hurtSound.play()
		PlayerState.DEAD:
			animated_sprite.play("hurt")
		PlayerState.DASH:
			animated_sprite.play("dash")

# --- CUSTOM FUNCTIONS ---

# Handles taking damage and entering the hurt state
func take_damage(amount: int = 1) -> void:
	if state == PlayerState.HURT or state == PlayerState.DEAD:
		return
	current_health -= amount
	current_health = max(current_health, 0)
	hurt_time = HURT_DURATION
	flash_timer = FLASH_INTERVAL
	velocity.y = JUMP_VELOCITY / 1.5
	emit_signal("hurt")
	print("Player got hit! Current health: ", current_health)
	ui.update_health(current_health)
	set_state(PlayerState.HURT)
	if current_health <= 0.0:
		player_killed()

# Handles player death and entering the dead state
func player_killed():
	print("You died!")
	collision_shape_2d.queue_free()
	emit_signal("died")
	Engine.time_scale = 0.5
	timer.start()
	set_state(PlayerState.DEAD)

# Timer timeout handler for respawn/reload
func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()

# Utility: get the Y position of the player's feet
func get_feet_y() -> float:
	var shape = $CollisionShape2D.shape as CircleShape2D
	return $CollisionShape2D.global_position.y + shape.radius

# Handles enemy stomping logic
func _on_stomp_area_area_entered(area):
	print("StompArea area entered:", area)
	if area.is_in_group("enemy"):
		if area.has_method("on_stomped"):
			area.on_stomped(self)
		velocity.y = -200
		emit_signal("stomped_enemy")
