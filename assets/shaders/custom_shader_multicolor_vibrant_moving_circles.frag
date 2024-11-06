 // Working With Fragment Shaders Part 3
 
 #version 460 core

 #include <flutter/runtime_effect.glsl>

 uniform vec2 uSize;
 uniform float iTime;

 // uniform vec4 uColor;

 out vec4 fragColor;

  // distance inverse function, typically 1 / x but needs to scalled down as the distance is between 0 and 1
 float inverse(float x) {
   return 0.02 / x;
}

// cosine based palette function, 4 vec3 params.
// create infinitly various color gradients by using the power of Trigonometry.

vec3 palette(float distance, vec3 a, vec3 b, vec3 c, vec3 d) {
  return a + b * cos(6.28318 * (c * distance + d));
}

 void main() {
   vec2 pixels = FlutterFragCoord() / uSize.xy;

   pixels = (pixels - 0.5) * 2;

   pixels.x *= uSize.x / uSize.y;

   // distance of pixels from origin
   float dist = length(pixels);

   vec3 a = vec3(0.5, 0.5, 0.5);

   vec3 b = vec3(0.5, 0.5, 0.5);

   vec3 c = vec3(1.0, 1.0, 1.0);

   vec3 d = vec3(0.263, 0.416, 0.557);

   // adding a time component to the distance will make the gradient color shift and evolve
   vec3 col = palette(dist + iTime, a, b, c, d);

   // vec3 col = palette(dist, a, b, c, d);

   // animation based on time double
   dist = sin(dist * 12.0 + iTime) / 12.0;

   dist = abs(dist);

   dist = inverse(dist);

   // play with augment operation type to see how the canvas is colored (e.g. += pr /=)
   col *= dist;

   fragColor = vec4(col, 1.0);
 }

 // d Distance

 //   - distance of pixels from origin

 //   - must use the length function and pass in pixels e.g. float d = length(pixels);

  // distance inverse function
  
  //   - typically 1 / x but needs to scalled down as the distance is between 0 and 1