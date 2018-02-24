precision mediump float;

uniform vec2 uResolution;

void main(){
    vec2 st = gl_FragCoord.xy / uResolution;
    
    st = fract(st);
    
    gl_FragColor = vec4(st.x, st.y, 0.0, 1.0);
}