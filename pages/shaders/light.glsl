precision mediump float;
uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uTime;

# define PI 3.1415926

vec2 des2pol(in vec2 st){
    return vec2(
        atan(st.x, st.y),
        sqrt(st.x*st.x+st.y*st.y)
    );
}

float plot(vec2 st){
    float line = 0.5+0.6 * abs(fract(uTime)-0.5) * sin(st.x*7.0);
    return smoothstep(line-0.05, line+0.05, st.y);
}

void main() {
  vec2 st = gl_FragCoord.xy / uResolution;
  st = mix(vec2(-1.0, -1.0), vec2(1.0, 1.0), st);
  st = des2pol(st);
  st.x += fract(uTime*PI*2.0);  
  float pct = plot(st);
  gl_FragColor = vec4(vec3(1.0-pct), 1.0);
}