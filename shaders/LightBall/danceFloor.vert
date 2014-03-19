/*
@Author: Gaurav Behere
*/
precision mediump float;
attribute vec4 a_position;
attribute vec2 a_texCoord;
uniform mat4 u_projectionMatrix;
uniform float angle;
uniform float rad;
uniform vec3 lightPosition;
const float PI = 3.1415;
vec3 to3DCord( vec2 uv, float r ) {
	vec3 p;
	float fi = uv.x * PI * 2.0;
	float th = uv.y * PI;
	p.x = r * sin( th ) * cos( fi );
	p.y = r * sin( th ) * sin( fi );
	p.z = r * cos( th );
	return p;
}
void main() {
    vec4 position = a_position;
	vec3 sp = to3DCord( a_texCoord, rad );
	position.xyz = mix( position.xyz, sp, 1.0 );
    float th = angle;
    mat4 rotationY = mat4(
                            cos(th), 0, sin(th), 0,
                            0, 1, 0, 0,
                            -sin(th), 0, cos(th), 0,
                            0, 0, 0, 1);
    float ang = - PI / 2.0 ;
    mat4 rotationX = mat4(
                            1, 0, 0, 0,
                            0, cos(ang),-sin(ang), 0,
                            0, sin(ang), cos(ang), 0,
                            0, 0, 0, 1);
	gl_Position = u_projectionMatrix * rotationY * rotationX * position;
	vec3 lightPositionNormalized = normalize( lightPosition );
	vec3 planeNormal = lightPositionNormalized;
	vec3 spNormal = normalize( position.xyz );
	vec3 normal = normalize( mix( planeNormal, spNormal, 1.0 ) );
}