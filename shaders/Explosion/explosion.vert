precision mediump float;
attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute vec2 a_meshCoord;
attribute vec3 a_triangleCoord;
uniform vec4 u_meshBox;
uniform vec2 u_tileSize;
uniform vec2 u_meshSize;
uniform mat4 u_projectionMatrix;
uniform vec2 u_textureSize;
uniform mat4 transform;
uniform float time;
uniform vec3 tileRotation;

const float translationMultiplier = 300.0;

mat4 translate(vec3 t) {
return mat4( 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0,
0.0, 1.0, 0.0, t.x, t.y, t.z, 1.0); }
mat4 rotateX(float f) {
    return mat4( 1.0, 0.0, 0.0, 0.0, 0.0, cos(f),
    sin(f), 0.0, 0.0, -sin(f), cos(f), 0.0, 0.0, 0.0, 0.0, 1.0);
 }
mat4 rotateY(float f) {
    return mat4( cos(f), 0.0, -sin(f), 0.0, 0.0, 1.0, 0.0, 0.0,
     sin(f), 0, cos(f), 0.0, 0.0, 0.0, 0.0, 1.0);
 }
mat4 rotateZ(float f) {
 return mat4( cos(f), sin(f), 0.0, 0.0, -sin(f), cos(f),
  0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0);
}
mat4 scale(vec3 f) { return mat4( f.x, 0.0, 0.0, 0.0, 0.0, f.y,
    0.0, 0.0, 0.0, 0.0, f.z, 0.0, 0.0, 0.0, 0.0, 1.0);
}
mat4 rotate(vec3 a) {
    return rotateX(a.x) * rotateY(a.y) * rotateZ(a.z);
}
float random(vec2 scale) {
    return fract(sin(dot(vec2(a_triangleCoord.x, a_triangleCoord.y), scale)) * 4000.0);
}


void main() {
    float rand = random(vec2(10.0,11.0));
    mat4 transformFactor = mat4(1.0);
    float timeFactor = 2.0 * time;
    if (timeFactor > 1.0)
        timeFactor = 2.0 - timeFactor;
    float radius = timeFactor * max(u_textureSize.x, u_textureSize.y);
    radius *= radius;
    float deltaX =  abs(0.5 - a_meshCoord.x) * u_textureSize.x;
    float deltaY = abs(0.5 - a_meshCoord.y) * u_textureSize.y;
    float sumDelta = deltaX * deltaX + deltaY * deltaY;
    vec3 targetVector = vec3(u_meshBox.x + u_tileSize.x * (a_triangleCoord.x + 0.5), u_meshBox.y + u_tileSize.y * (a_triangleCoord.y + 0.5), 0.0);
    transformFactor = translate(targetVector) * rotate(radians(vec3(tileRotation.x * rand * timeFactor, 2.0 * tileRotation.y * rand * timeFactor, 0.5 * rand * timeFactor * tileRotation.z))) * translate(-targetVector);
    transformFactor = translate(vec3(0.0, 0.0, timeFactor * time * sqrt(abs(radius - sumDelta)) * (0.8 + 0.4 * rand))) * transformFactor;
    transformFactor = translate(vec3(0.0, 0.0, (-0.5 + rand) * translationMultiplier * timeFactor)) * transformFactor;
    gl_Position = u_projectionMatrix * transform * transformFactor * a_position;
}