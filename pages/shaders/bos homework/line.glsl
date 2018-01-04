precision mediump float;
uniform vec2 uResolution;
uniform float uTime;

# define PI 3.1415926

vec2 edge0 = vec2(-10.0, -10.0);
vec2 edge1 = vec2(10.0, 10.0);

float curve(float x){
  // return x;
  // return pow(x, 2.0);
  // return step(0.5, x);
  // return x * x * (3.0 - 2.0 * x);
  // return mod(x, 0.5);
  // return fract(x);
  // return smoothstep(0.3, 0.8, x);
  // return sin(x);
  return sin(x) + sin(x * 1.3 - 0.92) + cos(x * 0.7 + 0.25) * 0.67;
}

float plot(vec2 st, vec2 box){
  return smoothstep(st.x - 0.01 * box.x, st.x,        st.y) - 
         smoothstep(st.x,        st.x + 0.01 * box.y, st.y);
}

vec2 resize(vec2 st, vec2 edge0, vec2 edge1){
  return edge0 * (1.0 - st) + edge1 * st;
}

void main() {
  vec2 st = gl_FragCoord.xy / uResolution;
  // st.x += fract(uTime) * PI / 10.0;
  st = resize(st, edge0, edge1);
  st.x = curve(st.x);
  float pct = plot(st, edge1 - edge0);
  gl_FragColor = vec4(
    (vec3(0.0, 1.0, 0.0) * pct + vec3(1.0, 1.0, 1.0) * st.x * (1.0 - pct)), 
    1.0
  );
}