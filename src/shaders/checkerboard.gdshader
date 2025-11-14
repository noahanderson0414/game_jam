shader_type spatial;

uniform float scale = 10.0;

void fragment() {
	vec2 uv = UV * scale;
	ALBEDO = vec3(mod(floor(uv.x) + floor(uv.y), 2.0));
}
