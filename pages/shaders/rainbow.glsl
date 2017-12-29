precision mediump float;
uniform vec2 uResolution;
uniform float uTime;

# define PI 3.1415926

vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0, 
                     0.0, 
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

vec2 des2pol(in vec2 st){
    return vec2(
        atan(st.x, st.y),
        sqrt(st.x*st.x+st.y*st.y)
    );
}

vec3 rainbow(in vec2 st){
    // return hsb2rgb(vec3(st.x, 1.0, st.y));
    return hsb2rgb(vec3(st.x, st.y, 1.0));
}

void main() {
  vec2 st = gl_FragCoord.xy / uResolution;
  st = mix(vec2(-1.0), vec2(1.0), st);
  st = des2pol(st);
  st.x += st.y * 5.0;
  vec3 color = rainbow(vec2(st.x/(2.0*PI)+fract(uTime/10.0)*2.0*PI, st.y));
  gl_FragColor = vec4(color, 1.0);
}