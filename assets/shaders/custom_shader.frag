 // Working With Fragment Shaders Part 7
 
 #version 460 core

 #include <flutter/runtime_effect.glsl>

 uniform vec2 uSize;
 uniform float iTime;

 // uniform vec4 uColor;

 out vec4 fragColor;

  // distance inverse function, typically 1 / x but needs to scalled down as the distance is between 0 and 1
 float inverse(float x) {

  // utilizing power function enhances the overall contrast of the image
   return pow(0.01 / x, 2);
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

// distance of pixels from origin within entire canvas

   float canvasDistance = length(pixels0);

   vec3 finalColor = vec3(0.0);

   // applying iterations with a for loop by adding color calculation logic within the loop, the iterating condition of the loop means: i < numberOfIterations i.e. numberOfIterations == 1 then normal flow numberOfIterations == 2 then two iterations etc

   for (float i = 0.0; i < 4.0; i++) {
    // scale pixels for fractal

   pixels *= 1.5;

   // fractal of pixels, creates a repeat effect

   pixels = fract(pixels);

   // center pixels within their fractal space

   pixels -= 0.5;

   // local distance of pixels from origin within each fractal repetition

   float localDistance = length(pixels) * exp(-length(pixels0));

   vec3 a = vec3(0.5, 0.5, 0.5);

   vec3 b = vec3(0.5, 0.5, 0.5);

   vec3 c = vec3(1.0, 1.0, 1.0);

   vec3 d = vec3(0.263, 0.416, 0.557);

   // adding a time component to the distance will make the gradient color shift and evolve
   // using the canvasDisstance instead of the local distance changes the entire canvas vs each individual spaced repetition

   // adding i * float to the palette creates a slight color offset 
   
   vec3 col = palette(canvasDistance + i * 0.4 + iTime * 0.4, a, b, c, d);

   // animation based on time double

   localDistance = sin(localDistance * 12.0 + iTime) / 12.0;

   localDistance = abs(localDistance);

   localDistance = inverse(localDistance);

   // play with augment operation type to see how the canvas is colored (e.g. += pr /=)

   finalColor += col * localDistance;
   }

   fragColor = vec4(finalColor, 1.0);
 }


// Reducing the Fequency of The Time Offset

//   - multiple your time variable by some fraction

//   - e.g. iTime * 0.4

//   - the lower the number the slower the effect