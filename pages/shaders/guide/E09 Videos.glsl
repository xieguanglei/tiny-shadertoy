precision mediump float;

uniform vec2 uResolution;
uniform sampler2D video0;
uniform float uTime;

void main(){
    vec2 st = gl_FragCoord.xy / uResolution;

    vec4 color = texture2D(video0, vec2(st.x, 1.0-st.y));
    float bright = (color.r + color.g + color.b)/3.0;

    if(fract((st.y+uTime)*300.0)<0.3){
        bright *= 1.5;
    }

    gl_FragColor = vec4(bright, bright, bright, 1.0);
}