 // Working With Fragment Shaders Part 2
 
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

 void main() {
   vec2 pixels = FlutterFragCoord() / uSize.xy;

   pixels = (pixels - 0.5) * 2;

   pixels.x *= uSize.x / uSize.y;

   // distance of pixels from origin
   float d = length(pixels);

   // colors are not limited to being between 0 and 1, the higher the color the more vibrant and intense the color is
   vec3 col = vec3(1.0, 2.0, 3.0);

   // animation based on time double
   d = sin(d * 12.0 + iTime) / 12.0;

   d = abs(d);

   d = inverse(d);

   // play with augment operation type to see how the canvas is colored (e.g. += pr /=)
   col *= d;

   fragColor = vec4(col, 1.0);
 }

 // d Distance

 //   - distance of pixels from origin

 //   - must use the length function and pass in pixels e.g. float d = length(pixels);

  // distance inverse function
  
  //   - typically 1 / x but needs to scalled down as the distance is between 0 and 1