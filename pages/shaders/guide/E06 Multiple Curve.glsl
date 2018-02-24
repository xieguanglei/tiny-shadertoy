precision mediump float;

#define PI 3.14159
#define WIDTH 0.01

uniform vec2 uResolution;

vec2 resize(vec2 st, vec4 rect){
    return vec2(rect[0], rect[1]) + vec2(rect[2], rect[3]) * st;
}

float curve1(float x){
    return cos(x*3.0)/2.0;
}

float curve2(float x){
    return sin(x*3.0)/2.0;
}

void main(){
    vec2 st = gl_FragCoord.xy / uResolution;

    st = resize(
        st,
        vec4(-1.0, -1.0, 2.0, 2.0)
    );

    float bright1 = abs(st.y - curve1(st.x)) < WIDTH ? 1.0 : 0.0;
    float bright2 = abs(st.y - curve2(st.x)) < WIDTH ? 1.0 : 0.0;

    float bright = 1.0 - (1.0-bright1) * (1.0-bright2);

    gl_FragColor = vec4(bright, bright, bright, 1.0);
}