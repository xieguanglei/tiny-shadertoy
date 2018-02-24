precision mediump float;

uniform vec2 uResolution;
uniform float uTime;

void main(){

	vec3 color;
    
    // float z = uTime;
    float z = 3.33;
	
    for(int i = 0; i < 3; i++) {
		
        vec2 p = gl_FragCoord.xy / uResolution.xy;

		vec2 uv = p;

		// p -= 0.5;
		// z += 0.07;

		float len = length(p);

		uv += p / len * (sin(z) + 1.0) * abs(sin( len * 9.0 - z * 2.0));

		color[i]= 0.01 / length(abs(mod(uv, 1.0) - 0.5)) / len;

	}


    gl_FragColor = vec4(color, 1.0);
}