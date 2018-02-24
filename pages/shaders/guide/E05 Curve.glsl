precision mediump float;

#define PI 3.14159
#define WIDTH 0.01

uniform vec2 uResolution;

vec2 resize(vec2 st, vec4 rect){
    return vec2(rect[0], rect[1]) + vec2(rect[2], rect[3]) * st;
}

float curve(float x){
    return smoothstep(-0.6, 0.6, x)-0.5;
}

void main(){
    vec2 st = gl_FragCoord.xy / uResolution;

    st = resize(
        st,
        vec4(-1.0, -1.0, 2.0, 2.0)
    );

    float bright = abs(st.y - curve(st.x)) < WIDTH ? 1.0 : 0.0;

    gl_FragColor = vec4(bright, bright, bright, 1.0);
}