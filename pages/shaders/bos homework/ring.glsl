precision mediump float;
uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uTime;

# define PI 3.1415926

void main() {
  vec2 st = gl_FragCoord.xy / uResolution;
  vec2 ms = uMouse / uResolution;

  st = mix(vec2(-1.0), vec2(1.0), st);
  st = abs(st);
  ms = mix(vec2(-1.0), vec2(1.0), ms);
  ms = abs(ms);

  float pct = distance(st, ms);
  pct = fract(pct * 20.0)*PI*2.0;
  pct = (sin(pct-fract(uTime*1.5)*PI*2.0)+1.0)/2.0;
  gl_FragColor = vec4(vec3(pct), 1.0);
}