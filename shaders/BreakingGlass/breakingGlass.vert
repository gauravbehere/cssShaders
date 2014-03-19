precision mediump float;
attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute vec3 a_triangleCoord;
uniform mat4 u_projectionMatrix;
uniform float amount;
uniform float t;
uniform float skew;
mat4 perspectiveMatrix(float p,float skew)
{   float perspective = - 1.0 / p;
    if(skew == 0.0){
    }
    else{
        skew =  skew;
    }
    return mat4(
	1.0, 0.0, 0.0, 0.0,
	0.0, 1.0, 0.0, 0.0,
	0.0, 0.0, 1.0, perspective,
	0.0, 0.0, 0.0, 1.0);
}

float random(vec2 scale)
{
    return fract(sin(dot(vec2(a_triangleCoord.x, a_triangleCoord.y), scale)) * 4000.0);
}

void main()
{
    float r = random(vec2(10.0, 80.0));
    vec4 pos = a_position;
    float dz = -amount * t * r;
    vec3 tc = a_triangleCoord;
    if (mod(tc.x + tc.y, 2.0) == 0.0) {
        dz = amount * t * r;
    }
    pos.z += dz;

    gl_Position = u_projectionMatrix * perspectiveMatrix(0.5,skew)  * pos;
}