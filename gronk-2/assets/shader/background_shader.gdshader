shader_type canvas_item;

uniform float scroll_speed = 0.1;
uniform vec2 offset = vec2(0.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv_offset = vec2(fract(UV.x + offset.x), UV.y);
	COLOR = texture(TEXTURE, uv_offset);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
