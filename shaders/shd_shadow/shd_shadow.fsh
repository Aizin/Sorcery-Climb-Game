varying float tdis; 
varying float ldis; 

void main(){
	float str = (1. - abs(tdis-0.5)*2./ldis)*5.;
    gl_FragColor = vec4(str); 
}