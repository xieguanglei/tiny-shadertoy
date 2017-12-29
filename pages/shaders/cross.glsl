precision mediump float;
uniform vec2 uResolution;
uniform float uTime;

# define PI 3.1415926

uniform vec2 u_resolution;
uniform float u_time;


float and(float x, float y){
    return x * y;
}

float or(float x, float y){
    return 1.0 - (1.0 - x) * (1.0 - y);
}

float neg(float x){
    return 1.0 - x;
}

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

float box(vec2 st, vec2 size){
    vec2 f = size/2.0 - abs(st);
    return f.x > 0.0 && f.y > 0.0 ? 1.0 : 0.0;
}

float cross(vec2 st, vec2 size){
    return or(box(st, size), box(st, vec2(size.y, size.x)));
}

void main(){
    vec2 st = gl_FragCoord.xy / uResolution;

    st = mix(vec2(-1.0, -1.0), vec2(1.0, 1.0), st);
    st = rotate2d( sin(uTime)*PI ) * st;
    st += vec2(0.3);

    float pct = cross(st, vec2(0.2, 0.05));
    gl_FragColor = vec4(vec3(pct),1.0);
}