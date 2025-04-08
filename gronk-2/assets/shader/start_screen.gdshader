shader_type canvas_item;

uniform sampler2D scroll_texture;
uniform vec2 offset = vec2(0.0);

void fragment() {
	vec2 uv = fract(UV + offset);
	COLOR = texture(scroll_texture, uv);
}
