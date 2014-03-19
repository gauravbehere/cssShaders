/*
@Author: Gaurav Behere
*/
precision mediump float;
attribute vec4 a_position;
attribute vec2 a_texCoord;
uniform mat4 u_projectionMatrix;
uniform float time;
vec3 ripple(vec2 uv) {
    vec2 cPos = -1.0 + 2.0 * uv.xy ;
    float cLength = length(cPos);
    vec2 s = uv.xy+(cPos/cLength)*cos(cLength*12.0-time*4.0)*0.03;
    vec3 p = vec3(s,1.0);
    p.x -= .5;
    p.y -= .5;
    return p;
}

void main()
{
    vec4 p = a_position;
    vec3 m = ripple(a_texCoord);
    if(time != 0.0) {
        p.xyz = mix(p.xyz, m, 1.);
    }
    gl_Position = u_projectionMatrix  * p;
}