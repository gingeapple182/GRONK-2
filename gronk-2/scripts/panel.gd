extends Panel

@export var scroll_speed: float = 0.05
var offset_x: float = 0.0

func _ready() -> void:
	# Optional: Set size to match viewport
	size = get_viewport_rect().size

func _process(delta: float) -> void:
	offset_x += scroll_speed * delta
	material.set_shader_parameter("offset", Vector2(offset_x, 0))
