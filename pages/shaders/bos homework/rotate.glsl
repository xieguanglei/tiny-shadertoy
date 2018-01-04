precision mediump float;
uniform vec2 uResolution;
uniform float uTime;

# define PI 3.1415926

vec2 rotate2D (vec2 st, float angle) {
  st -= 0.5;
  st =  mat2(cos(angle),-sin(angle),
              sin(angle),cos(angle)) * st;
  st += 0.5;
  return st;
}

vec3 innerTile(vec2 st, float uTime, float offset){
  st = rotate2D(st, PI * offset * 2.0 + uTime);
  float pct = step(1.0, st.x + st.y);
  return vec3(pct);
}

vec3 tile(vec2 st, float uTime){
  st = st * 2.0;
  vec2 f = floor(st);
  float offset = 0.0;
  if(f.y == 0.0){
    offset = f.x * -0.25;
  }else{
    if(f.x == 1.0){
      offset = 0.5;
    }else{
      offset = 0.25;
    }
  }

  st = fract(st);
  return vec3(innerTile(st, uTime, offset));
}

void main() {
  vec2 st = gl_FragCoord.xy / uResolution;
  st = st * 10.0;
  st = fract(st);
  vec3 color = tile(st, uTime);
  gl_FragColor = vec4(color, 1.0);
}