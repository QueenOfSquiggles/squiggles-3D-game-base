shader_type canvas_item;

uniform float num_colors = 2.0;
uniform float pixelate_amount = 32.0;
uniform vec2 screen_size = vec2(1024.0, 600.0);

const float bayer_matrix[] = {
	0.0, 8.0, 2.0, 10.0,
	12.0, 4.0, 14.0, 6.0,
	3.0, 11.0, 1.0, 9.0,
	15.0, 7.0, 13.0, 5.0
};
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
	return (c.r * 0.3) + (c.g * 0.3) + (c.b * 0.3);
}

vec3 dither(vec3 input, vec2 screen_pos){
	vec2 pixel = mod(floor(screen_pos), bayer_matrix_width);
	int index = int(pixel.x + pixel.y * bayer_matrix_width);
	float threshold = (bayer_matrix[index] / bayer_matrix_order) - 0.5;
	
	float light = luma(input);
	
	if (light < threshold) {
		return vec3(0.0);
	}
	return input;
}

void fragment() {
	vec2 factor = screen_size / pixelate_amount;
	vec2 pixel_coords = round(SCREEN_UV * factor) / factor;
	pixel_coords = SCREEN_UV;
	vec3 sample = texture(SCREEN_TEXTURE, pixel_coords).rgb;
	sample = posterize(sample, 0.9, num_colors);
	sample = dither(sample, pixel_coords);
	COLOR = vec4(sample, 1.0);
}