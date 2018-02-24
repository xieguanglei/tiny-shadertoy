precision mediump float;

uniform vec2 uResolution;
uniform sampler2D image0;

void main(){
    vec2 st = gl_FragCoord.xy / uResolution;

    gl_FragColor = texture2D(image0, st);
}