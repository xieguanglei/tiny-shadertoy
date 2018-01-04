precision mediump float;
uniform vec2 uResolution;
uniform float uTime;

# define PI 3.1415926

mat2 rotate2d(float angle){
  return mat2(cos(angle),-sin(angle),
              sin(angle),cos(angle));
}

float random (vec2 st) {
    return fract(
        sin(
          dot(st.xy, vec2(12.9898,22.233))
        ) * 43758.5453123);
}

vec2 random2(vec2 st){
  st = vec2( dot(st,vec2(1.271,3.117)),
            dot(st,vec2(2.695,1.833)) );
  st = -1.0 + 2.0*fract(sin(st)*43758.5453123);
  return st;
}

// block noise
float noise(vec2 ist, vec2 fst){
  float p1 = random(ist);
  float p2 = random(ist + vec2(1.0, 0.0));
  float p3 = random(ist + vec2(0.0, 1.0));
  float p4 = random(ist + vec2(1.0, 1.0));

  fst = smoothstep(0.0, 1.0, fst);
  
  float p = mix(
    mix(p1, p2, fst.x),
    mix(p3, p4, fst.x),
    fst.y
  );
  return p;
}

// gradient noise
float noise2(vec2 ist, vec2 fst){
  vec2 g1 = random2(ist+vec2(0.0, 0.0));
  vec2 g2 = random2(ist+vec2(1.0, 0.0));
  vec2 g3 = random2(ist+vec2(0.0, 1.0));
  vec2 g4 = random2(ist+vec2(1.0, 1.0));

  vec2 f1 = fst - vec2(0.0, 0.0);
  vec2 f2 = fst - vec2(1.0, 0.0);
  vec2 f3 = fst - vec2(0.0, 1.0);
  vec2 f4 = fst - vec2(1.0, 1.0);

  float p1 = dot(g1, f1);
  float p2 = dot(g2, f2);
  float p3 = dot(g3, f3);
  float p4 = dot(g4, f4);

  fst = smoothstep(0.0, 1.0, fst);
  
  float p = mix(
    mix(p1, p2, fst.x),
    mix(p3, p4, fst.x),
    fst.y
  );

  return p;
}

float plotStrips(vec2 st){
  float y = fract(st.y);
  if(y < 0.3){
    return 0.0;
  }else{
    return 1.0;
  }
}

vec2 skew (vec2 st) {
    vec2 r = vec2(0.0);
    r.x = 1.1547 * st.x;
    r.y = st.y + 0.5 * r.x;
    return r;
}

vec3 plotGrid(vec2 st){
    st = fract(st);
    float thr = 0.05;
    if(st.x < thr || st.y < thr || abs(st.x - st.y) < thr){
        return vec3(0.5);
    }else{
        return vec3(1.0);
    }
}

void main() {
    vec2 st = gl_FragCoord.xy / uResolution;
    st = st * 10.0;
    st = skew(st);
    vec3 color = plotGrid(st);
    gl_FragColor = vec4(color, 1.0);
}