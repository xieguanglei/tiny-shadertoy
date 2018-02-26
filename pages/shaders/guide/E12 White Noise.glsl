precision mediump float;

#define PI 3.14159
#define WIDTH 0.01

uniform vec2 uResolution;
uniform float uTime;

vec2 resize(vec2 st, vec4 rect){
    return vec2(rect[0], rect[1]) + vec2(rect[2], rect[3]) * st;
}

float random(vec2 st){
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))
                 * 43758.5453123);
}

void main(){

    vec2 st = gl_FragCoord.xy / uResolution;

    st = resize(
        st+sin(uTime),
        vec4(-1.0, -1.0, 2.0, 2.0)
    );

    float b = random(st);
    gl_FragColor = vec4(b, b, b, 1.0);
}