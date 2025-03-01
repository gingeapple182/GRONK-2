extends TextureRect

@export var scroll_speed: float = 0.05
var offset_x: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size = get_viewport_rect().size

func _process(delta: float) -> void:
	offset_x += scroll_speed * delta
	material.set_shader_parameter("offset", Vector2(offset_x, 0))
