precision mediump float;
uniform vec2 uResolution;
uniform float uTime;

# define PI 3.1415926

vec2 edge0 = vec2(-10.0, -10.0);
vec2 edge1 = vec2(10.0, 10.0);

float random(float x){
  return fract(sin(x)*100000.0);
}

float curve(float x){
  float time = fract(uTime/10.0);
  float f = fract(x);
  x = floor(x);
  float s = random(x + time);
  float s2 = random(x + 1.0 + time);
  s = mix(s, s2, smoothstep(0.0, 1.0, f));
  // s = smoothstep(s, s2, f);
  return s;
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
    vec3(0.0, 1.0, 0.0) * pct,
    1.0
  );
}