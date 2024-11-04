// GLSL - OpenGL Shading Language

#version 460 core

// flutter specific helpers

#include <flutter/runtime_effect.glsl>

// uniform keyword

//   - any parameters that your shader should except from outside entities

//   - syntax:

//       - uniform Type variableName;

//   - typically uniform variables start with the letter: u

//   - uniform variables are constant values for every pixel a shader computes of a frame

// Basic Shader Parameters

//   - accepts 6 floats that will be bundled into two vectors of lenth 2 and 4

//   - GLSL makes heavy use of vectors of length 2, 3, and 4

// total surface area
uniform vec2 uSize;

// the color the shader should paint
uniform vec4 uColor;

// the value that the shader will return, should always be a vect4 represending (red, green, blue, alpha) color values
out vec4 FragColor;

void main() {
    FragColor = vec4(uColor.r, uColor.g, uColor.b, uColor.a);

    // the simplified way, as uColor is alreadty a vec4

    // FragColor = uColor;
}

// Passing Properties to GLSL

//   - if a uniform is not used it seems to mess up the
/      order of variables being passed in