shader_type canvas_item;


uniform float screen_width = 1920;
uniform float screen_height = 1080;
uniform vec2 center = vec2(0.5f);
uniform vec2 player = vec2(0.5f);

uniform float progress : hint_range(-1,2.5);
uniform float pixel_size = 30;
uniform float circle_size : hint_range(0,2) = 1.5f;
uniform float curtains : hint_range(0,1) = 1;

uniform int type : hint_range(0,4) = 0;


void fragment() {
	float xFraction = fract(FRAGCOORD.x / pixel_size);
	float yFraction = fract(FRAGCOORD.y / pixel_size);
	
	float xDistance = abs(xFraction - 0.5);
	float yDistance = abs(yFraction - 0.5);
	
	if (xDistance - yDistance + UV.x + UV.y > progress)
		discard;
		
}
