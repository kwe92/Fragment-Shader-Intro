#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform vec4 uColor;
uniform vec4 gradientColor;
uniform float spread;


out vec4 oColor;

void main() {
    // divide current raw coordinates by uSize to normalize pixel values

    vec2 pixel = FlutterFragCoord() / uSize;

    vec4 white = vec4(1.0);

    // explicitly manipulating a colors alpha
    // pull the red, green, and blue channels from the uColor variable with the .rgb getter
    // multiply the rgb colors by the alpha color and pass the original alpha color back to . the vec4

    vec4 colorWithAlpha = vec4(uColor.rgb * uColor.a, uColor.a);

    oColor = mix(colorWithAlpha, gradientColor, pixel.x / spread);
}

// mix

//   - a way to interpolate between two colors