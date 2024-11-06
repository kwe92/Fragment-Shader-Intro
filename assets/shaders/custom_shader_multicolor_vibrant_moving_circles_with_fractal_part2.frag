 // Working With Fragment Shaders Part 5
 
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

   // pixels before apply fractal transformation
   vec2 pixels0 = pixels;

   // scale pixels for fractal
   pixels *= 2.0;

   // fractal of pixels, creates a repeat effect
   pixels = fract(pixels);

   // center pixels within their fractal space
   pixels -= 0.5;


   // local distance of pixels from origin within each fractal repetition
   float localDistance = length(pixels);

   // distance of pixels from origin within entire canvas
   float canvasDistance = length(pixels0);

   vec3 a = vec3(0.5, 0.5, 0.5);

   vec3 b = vec3(0.5, 0.5, 0.5);

   vec3 c = vec3(1.0, 1.0, 1.0);

   vec3 d = vec3(0.263, 0.416, 0.557);

   // adding a time component to the distance will make the gradient color shift and evolve
   // using the canvasDisstance instead of the local distance changes the entire canvas vs each individual spaced repetition
   vec3 col = palette(canvasDistance + iTime, a, b, c, d);

   // animation based on time double
   localDistance = sin(localDistance * 12.0 + iTime) / 12.0;

   localDistance = abs(localDistance);

   localDistance = inverse(localDistance);

   // play with augment operation type to see how the canvas is colored (e.g. += pr /=)
   col *= localDistance;

   fragColor = vec4(col, 1.0);
 }

 // d Distance

 //   - distance of pixels from origin

 //   - must use the length function and pass in pixels e.g. float d = length(pixels);

  // distance inverse function
  
  //   - typically 1 / x but needs to scalled down as the distance is between 0 and 1

// Adding a Fractal Repeat Effect | Spaced repetition

//   - must ensure that the operation is taking place in the desired clip space -1 to 1
//     instead of the 0 to 1 range