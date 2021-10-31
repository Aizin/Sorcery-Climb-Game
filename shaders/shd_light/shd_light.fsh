varying vec2 pos; //current pixel position
varying vec4 col;
varying vec2 v_vTexcoord;

uniform vec2 u_pos; //light source positon

uniform float zz; //larger zz, larger light
uniform float u_str; //strength
uniform float u_dir; //direction
uniform float u_fov; //field of vision


#define PI 3.1415926538

void main(){
	vec2 dis = pos - u_pos;
	float str = 1./(sqrt(dis.x*dis.x + dis.y*dis.y + zz*zz)-zz+1.-u_str); //strength of light is the inverse distance
    
	//convert to radians
	float dir = radians(u_dir);
	float hfov = radians(u_fov)*0.5;
	
	
	//setup FOV
	if (hfov < PI){
		float rad = atan(-dis.y,dis.x);	
		float adis = abs(mod(rad+2.*PI,2.*PI) - dir);
		adis = min(adis, 2.*PI - adis);
		str *= clamp((1.-adis/hfov)*5.,0.,1.);
	}
	
	//render
	vec4 frag = texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor = col*vec4(vec3(str),1.)*frag;
}
