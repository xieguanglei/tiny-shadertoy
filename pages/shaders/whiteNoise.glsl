precision mediump float;
uniform vec2 uResolution;
uniform float uTime;

# define PI 3.1415926

float random (vec2 st) {
    float t = fract(uTime);
    return fract(
        sin(dot(st.xy, vec2(12.9898,22.233) + fract(uTime)*10.0)) * 
        43758.5453123);
}

void main() {
    vec2 st = gl_FragCoord.xy / uResolution;
    st = floor(st*pow(5.0, 1.0+fract(uTime)*3.0));
    float rnd = random( st );
    gl_FragColor = vec4(vec3(rnd),1.0);
}