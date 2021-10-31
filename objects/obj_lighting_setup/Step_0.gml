/// @desc

function Quad(_vb,_x1,_y1,_x2,_y2) {
	vertex_position_3d(_vb, _x1, _y1, 0);
	vertex_position_3d(_vb, _x1, _y1, 2);
	vertex_position_3d(_vb, _x2, _y2, 1);
	
	vertex_position_3d(_vb, _x1, _y1, 2);
	vertex_position_3d(_vb, _x2, _y2, 1);
	vertex_position_3d(_vb, _x2, _y2, 3);
}

/*
if (mouse_check_button_pressed(mb_left)) {
	with (instance_create_depth(mouse_x, mouse_y, depth, obj_light)) {
		color = obj_moving_light.color;
		size = obj_moving_light.size;
	}
}
*/

vertex_begin(vb, vf);
var _vb = vb;
with (obj_wall) {
	if (slope) {
		if (dir == 1) {
			Quad(_vb,x,y,x+sprite_width,y+sprite_height);
			Quad(_vb,x,y+sprite_height,mid_x,mid_y);
		} else {
			Quad(_vb,x+sprite_width,y,x,y+sprite_height);
			Quad(_vb,x+sprite_width,y+sprite_height,mid_x,mid_y);
		}
	} else {
		Quad(_vb, x, y, x+sprite_width, y+sprite_height);
		Quad(_vb, x+sprite_width, y, x, y+sprite_height);
	}
	 
}
vertex_end(vb);

if (instance_exists(obj_level_endscreen) || instance_exists(obj_pause_menu)) {
	bloom_intensity = approach(bloom_intensity, 0, 0.04);
} else {
	bloom_intensity = approach(bloom_intensity, bloom_intensity_max, 0.04);
}