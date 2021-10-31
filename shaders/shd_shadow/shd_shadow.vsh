attribute vec3 in_Position;                  // (x,y,z)

uniform vec2 u_pos; 

const float len = 100000.;

varying float tdis;
varying float ldis;


void main(){
	vec2 pos = in_Position.xy;
	vec2 dis = pos - u_pos;
	float sdis = length(dis); //scalar distance
	if (in_Position.z > 1.){ 
		pos += dis/sdis * len; 
		tdis = in_Position.z-2.;
		ldis = 1.;
	}
	else{
		ldis = 	sdis/len;
		tdis = mix(0.5,in_Position.z,ldis);
	}
    vec4 object_space_pos = vec4( pos.x, pos.y, 0., 1.0); 
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
}
