#version 460 core

#include <flutter/runtime_effect.glsl>

// uniform vec2 uSize;

uniform vec4 uColor;

out vec4 oColor;

void main() {
    oColor = uColor;
}