shader_type canvas_item;

uniform sampler2D palette;

void fragment()
{
	// Define the amount of colours that will appear in the final image
	// based on the width of the input texture
	int levels = textureSize(palette, 0).x;
	// Capture the colour of the current screen fragment
	vec4 screen_fragment = texture(SCREEN_TEXTURE, SCREEN_UV);
	// Calculate the greyscale value of that fragment using the dot product
	// NOTE: This uses the "luminosity" method of greyscale conversion
	float greyscale = dot(screen_fragment.rgb, vec3(0.299, 0.587, 0.114));
	// Quantize that value into distinct steps by normalizing it
	float quantized = floor(greyscale * float(levels)) / float(levels);
	// Set the output based on the quantised value
	vec4 output = vec4(quantized, quantized, quantized, screen_fragment.a);
	// Swap out the color based on the red value of the current output
	// NOTE: Since the output is greyscale, this should be the same as blue and green
	output.rgb = texture(palette, vec2(output.r, 0.0)).rgb;
	
	// Finalize the output and send it to the screen
	COLOR = output;
}