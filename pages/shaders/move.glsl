precision mediump float;
uniform vec2 uResolution;
uniform float uTime;

float cross(vec2 st, float pct){
  vec2 pctCrossXY = smoothstep(vec2(0, 0), vec2(0.04, 0.04), abs(st));
  float pctCross = min(pctCrossXY.x, pctCrossXY.y);
  return min(pctCross, pct);
}

float diamond(vec2 st, float pct, vec2 offset){
  st = st - offset;
  float pctDiamond = smoothstep(0.38, 0.42, abs(st.x) + abs(st.y));
  return min(pctDiamond, pct);
}

vec3 tile(vec2 st, vec2 dir, float uTime){
  // transform to [-1, 1]
  st = mix(vec2(-1.0, -1.0), vec2(1.0, 1.0), st);

  float pct = 1.0;

  float t = fract(uTime)*2.0;
  pct = cross(st, pct);
  if(t < 1.0){
    if(dir.y > 0.0){
      pct = diamond(st, pct, vec2(2.0-t * 2.0, 0.0));
      pct = diamond(st, pct, vec2(0.0-t * 2.0, 0.0));
    }else{
      pct = diamond(st, pct, vec2(0.0+t * 2.0, 0.0));
      pct = diamond(st, pct, vec2(-2.0+t * 2.0, 0.0));
    }
  }else{
    t = t - 1.0;
    if(dir.x > 0.0){
      pct = diamond(st, pct, vec2(0.0, 0.0+t * 2.0));
      pct = diamond(st, pct, vec2(0.0, -2.0+t * 2.0));
    }else{
      pct = diamond(st, pct, vec2(0.0, 2.0-t * 2.0));
      pct = diamond(st, pct, vec2(0.0, 0.0-t * 2.0));
    }
  }

  return vec3(pct);
}

void main() {
  vec2 st = gl_FragCoord.xy / uResolution;
  st = st * 5.0;
  vec2 dir = mix(vec2(-1.0), vec2(1.0), sign(mod(st, 2.0)-1.0));
  st = fract(st);
  vec3 color = tile(st, dir, uTime );
  gl_FragColor = vec4(color, 1.0);
}