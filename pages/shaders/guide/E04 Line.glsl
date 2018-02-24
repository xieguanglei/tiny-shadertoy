precision mediump float;

uniform vec2 uResolution;


void main(){
    vec2 st = gl_FragCoord.xy / uResolution;

    float bright = abs(st.y - st.x) < 0.01 ? 1.0 : 0.0;

    gl_FragColor = vec4(bright, bright, bright, 1.0);
}