//   _____           _       _   _                 
//  / ____|         | |     | | | |                
// | |  __  ___   __| | ___ | |_| |__   ___  _   _ 
// | | |_ |/ _ \ / _` |/ _ \| __| '_ \ / _ \| | | |
// | |__| | (_) | (_| | (_) | |_| |_) | (_) | |_| |
//  \_____|\___/ \__,_|\___/ \__|_.__/ \___/ \__, |
//                                            __/ |
//                                           |___/ 
// Godotboy
// https://github.com/ItsSeaJay/godotboy
//
// MIT License
//
// Copyright (c) 2019 Callum John
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
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