 // Working With Fragment Shaders Part 1
 
 #version 460 core

 #include <flutter/runtime_effect.glsl>

 uniform vec2 uSize;
 uniform float iTime;

 // uniform vec4 uColor;

 out vec4 fragColor;

 void main() {
   // normailze canvas size into clip space -1 to 1

   vec2 pixels = FlutterFragCoord() / uSize.xy;

   // center pixel coordinates to the center of the screen and ensure the canvas range is -1 to 1 to acheive in one line: vec2 pixels = FlutterFragCoord() / uSize.xy * 2.0 - 1.0;

   pixels = (pixels - 0.5) * 2;

   // fix streching by multiplying pixels.x by aspect ratio of the canvas | aspect ratio = uSize.x / uSize.y to acheive in one line (WRONG, MATH IS OFF FIX THIS): vec2 pixels = FlutterFragCoord() * 2.0 - uSize.xy / uSize.y;

   pixels.x *= uSize.x / uSize.y;

   // distance of pixels from origin

   float d = length(pixels);

   // d -= 0.225;

  // animation based on time double

   d = sin(d * 12.0 + iTime) / 12.0;

   d = abs(d);

   // d = smoothstep(0.0, 0.1, d);

   // creates a solid color instead of blurry gradient
   
   d = step(0.025, d);

   // fragColor = uColor;

   // fragColor = vec4(pixels.xy, 0.0, 1.0);

   fragColor = vec4(d, d, d, 1.0);
 }

 // Flutter Coordinate Origin

 //   - original origin located at the top left of the screen for mobile

 // Centering Origin

 //   - makes it easier to create complex and dynamic renderings

 // length function

 //   - distance from origin to pixel

 // pixels / uv variable

 //   - represents transformed pixel coordinates

 // uSize / iResolution

 //   - represents the size of the current canvas (current canvas resolution)

 //   - typical a vec3 with (width(x), height(y), depth(z))

 //   - depth required for 3-d rendering

 // fragment coordinates

 //   - depends on the size of the canvas and should be normailzed