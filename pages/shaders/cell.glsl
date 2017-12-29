precision mediump float;
uniform vec2 uResolution;
uniform float uTime;

# define PI 3.1415926

struct cell{
    vec3 flag;
    vec3 color;
};

float grid(vec2 st, vec2 edge0, vec2 edge1, float width){
  vec2 bl = vec2(1.0) - (smoothstep(edge0-vec2(width/2.0), edge0, st) - smoothstep(edge0, edge0+vec2(width/2.0), st));
  vec2 tr = vec2(1.0) - (smoothstep(edge1-vec2(width/2.0), edge1, st) - smoothstep(edge1, edge1+vec2(width/2.0), st));
  return bl.x * bl.y * tr.x * tr.y;
}

float and(float x, float y){
    return x * y;
}

float or(float x, float y){
    return 1.0 - (1.0 - x) * (1.0 - y);
}

float neg(float x){
    return 1.0 - x;
}

cell box(vec2 st, vec2 edge0, vec2 edge1, float width, vec3 color){
  vec2 outbl = 1.0 - step(edge0 - width/2.0, st);
  vec2 outtr = step(edge1 + width/2.0, st);
  vec2 inbl = step(edge0 + width/2.0, st);
  vec2 intr = 1.0 - step(edge1 - width/2.0, st);
  float outbox = or(or(outbl[0], outbl[1]), or(outtr[0], outtr[1]));
  float inbox = and(and(inbl[0], inbl[1]), and(intr[0], intr[1]));
  float onborder = neg(or(outbox, inbox));
  return cell(vec3(outbox, onborder, inbox), color);
}

cell apply(cell c1, cell c2){
    float outbox = and(c1.flag[0], c2.flag[0]);
    float onborder = or(c1.flag[1], c2.flag[1]);
    float inbox = neg(or(outbox, onborder));
    vec3 color = and(c2.flag[2], inbox) == 1.0 ? c2.color : c1.color;
    color = onborder == 1.0 ? vec3(0.0, 0.0, 0.0) : color;
    return cell(vec3(outbox, onborder, inbox), color);
}

void main() {
  vec2 st = gl_FragCoord.xy / uResolution;
  cell c = cell(vec3(1.0, 0, 0), vec3(0.0, 0.0, 0.0));
  c = apply(c, box(st, vec2(-0.5, -0.5), vec2(1.5, 1.5), 0.01, vec3(.93, .93, .93)));
  c = apply(c, box(st, vec2(0.17, 0.21), vec2(0.81, 0.82), 0.01, vec3(1.0, 1.0, 0.0)));
  c = apply(c, box(st, vec2(0.66, 0.53), vec2(0.88, 0.91), 0.01, vec3(1.0, 0.0, 1.0)));
  c = apply(c, box(st, vec2(0.31, 0.72), vec2(0.54, 0.95), 0.01, vec3(0.0, 1.0, 1.0)));
  c = apply(c, box(st, vec2(0.07, 0.12), vec2(0.83, 0.58), 0.01, vec3(1.0, 0.5, 0.5)));
  gl_FragColor = vec4(c.color, 1.0);
}