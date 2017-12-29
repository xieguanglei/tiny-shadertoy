precision mediump float;
uniform vec2 uResolution;
uniform float uTime;

# define PI 3.1415926

bool random (vec2 st) {
    float t = fract(
        sin(dot(st.xy, vec2(12.9898,22.233) * 43758.5453123)
    ));
    return t > 0.5;
}

vec3 plot(vec2 ist, vec2 fst){
    bool flag = random(ist);
    float pct = smoothstep(0.98, 1.00, 1.0 - abs(fst.x - fst.y));
    if(flag){
        pct = smoothstep(0.98, 1.00, 1.0 - abs(fst.x+fst.y-1.0));
    }
    return vec3(pct);
}

void main() {
    vec2 st = gl_FragCoord.xy / uResolution;
    st = st * 20.0;
    vec2 ist = floor(st);
    vec2 fst = fract(st);
    vec3 color = plot(ist, fst);
    gl_FragColor = vec4(color, 1.0);
}