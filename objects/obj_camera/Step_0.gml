/// @desc

if (global.game_paused) {
	return;
}

if (!instance_exists(follow)) exit;

cx = CX;
cy = CY;
var cw = CW;
var ch = CH;

with (follow) {
	if (!instance_exists(follow)) exit;
	x = follow.x;
	y = follow.y;
		
	if (instance_exists(global.cur_room)) {
		if (global.camera_lock) {
			x = clamp(x, global.cur_room.bbox_left + CW/2, global.cur_room.bbox_right - CW/2);
			y = clamp(y, global.cur_room.bbox_top + CH/2, global.cur_room.bbox_bottom - CH/2);
		}
		
		camera_set_view_size(CAM, 
			lerp(cw, global.CW_default*global.cur_room.view_scale, 0.1), 
			lerp(ch, global.CH_default*global.cur_room.view_scale, 0.1));
	}
}
	
cx = lerp(cx, follow.x - CW/2, 0.1);
cy = lerp(cy, follow.y - CH/2, 0.1);

cx += shake_x;
cy += shake_y;

cx = clamp(cx, 0, room_width-global.CW_default);
cy = clamp(cy, 0, room_height-global.CH_default);

var xx = cx;
var yy = cy;

// Set camera pos
camera_set_view_pos(CAM, xx, yy);