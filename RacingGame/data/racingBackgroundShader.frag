#ifdef GL_ES
precision mediump float;
#endif

const float PI = 3.1415926535;

uniform float u_time;
uniform vec2 u_resolution;

void main(){
    vec2 coord = 4.0 * gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.01);
    
    color += sin(coord.x * cos(u_time / 130.0) * 1.0) + sin(coord.y * cos(u_time / 140.0) * 1.0);
    color += cos(coord.y * sin(u_time / 120.0) * 1.0) + cos(coord.x * sin(u_time / 240.0) * 1.0);
    color *= sin(u_time / 10.0) * 0.3;

    gl_FragColor = vec4(color, 1.0);
    
}