/*
@Author: Gaurav Behere
*/
precision mediump float;
attribute vec4 a_position;
attribute vec2 a_texCoord;
uniform mat4 u_projectionMatrix;
uniform float t;
float distance;
void main()
{
    vec4 targetPosition = vec4(0.,0.5,0.0,1.0);
    vec4 position=a_position;
    vec4 direction=targetPosition-position;
    distance=length(direction);
    vec4 normalDirection = normalize(direction);
    gl_Position=u_projectionMatrix * (position + (2.5-distance) * t * normalDirection);
}