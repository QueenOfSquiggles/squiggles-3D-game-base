shader_type canvas_item;

uniform float num_colors = 16.0;
uniform float pixelate_amount = 20.0;
uniform vec2 screen_size = vec2(1024.0, 600.0);
uniform float motion_scale = 0.0;

uniform float threshold_succeed_value = 1.0;
uniform float threshold_fail_value = 0.1;
uniform float threshold_bias = -0.2;
const float bayer_matrix[] = {
	0.0, 8.0, 2.0, 10.0,
	12.0, 4.0, 14.0, 6.0,
	3.0, 11.0, 1.0, 9.0,
	15.0, 7.0, 13.0, 5.0
};
/*
const float bayer_matrix[] = {
	0.0, 6.0, 0.0, 8.0,
	10.0, 2.0, 12.0, 4.0,
	2.0, 10.0, 0.0, 8.0,
	14.0, 6.0, 12.0, 4.0
};
*/
const float bayer_matrix_width = 4.0;
const float bayer_matrix_order = 16.0;

vec3 posterize(vec3 input, float gamma, float numColours){
	vec3 c = pow(input, vec3(gamma));
	c = c * numColours;
	c = floor(c);
	c = c / num_colors;
	c = pow(c, vec3(1.0 / gamma));
	return c;
}

float luma(vec3 c){
	return (c.r * 0.2126) + (c.g * 0.7152) + (c.b * 0.0722);
}

float dither_1f(float input, vec2 screen_pos){
	float unclamped_index = mod(screen_pos.x + screen_pos.y * bayer_matrix_width, 16.0);
	int index = int(unclamped_index);
	float threshold = (bayer_matrix[index] / bayer_matrix_order) + threshold_bias;
	return (input > threshold)? threshold_succeed_value : threshold_fail_value;
}

vec3 dither(vec3 input, vec2 screen_pos, vec3 offsets){
	vec3 result = vec3(0.0);
	result.r = dither_1f(input.r, screen_pos + vec2(offsets.x, 0.0)) * input.r;
	result.g = dither_1f(input.g, screen_pos + vec2(offsets.y, 0.0)) * input.g;
	result.b = dither_1f(input.b, screen_pos + vec2(offsets.z, 0.0)) * input.b;
	return result;
}

vec2 pixelate(vec2 uv) {
	vec2 factor = floor(screen_size) / pixelate_amount;
	return round(uv * factor) / factor;
}


varying flat vec3 dither_offsets;
const float time_scale = 5.0;
const float dither_offset_amount = 1.0;

void vertex(){
	dither_offsets = vec3(0.0);
	dither_offsets.x = TIME * time_scale * dither_offset_amount;
	dither_offsets.y = (TIME + 0.2) * time_scale * dither_offset_amount;
	dither_offsets.z = (TIME - 0.2) * time_scale * dither_offset_amount;
	dither_offsets *= motion_scale;
}

void fragment() {
	vec3 sample = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	sample = dither(sample, (SCREEN_UV * screen_size), dither_offsets);
	sample = posterize(sample, 0.9, num_colors);
	COLOR = vec4(sample, 1.0);
}