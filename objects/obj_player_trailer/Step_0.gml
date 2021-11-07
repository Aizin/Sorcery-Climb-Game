/// @desc

if (global.game_paused) {
	image_speed = 0;
	return;
}

if (!down) {
	process_movement();
}
process_animation();

var room_inst = instance_place(x,y,obj_room);
global.cur_room = room_inst;

xscale = lerp(xscale, 1, 0.2);
yscale = lerp(yscale, 1, 0.2);

if (instance_exists(obj_door)) {
	if (global.key_up_pressed && place_meeting(x, y, obj_door)) {
		global.can_pause = false;
		
		var d = instance_place(x,y,obj_door);
		instance_destroy();
		
		var s = instance_create_depth(d.x, d.y, depth, obj_sprite_animate);
		with (s) {
			sprite_index = spr_player_door_enter;
			
			function destroy() {
				instance_create_layer(0,0,"Game",obj_level_endscreen);
			}
		}
	}
}

dash_alpha = approach(dash_alpha, dashing ? 1 : 0, 0.005);
horizontal_lock = approach(horizontal_lock, 0, 1);

if (dash_alpha > 0.6 && movement_pause != 0) {
	if (x_save != -1) {
		x = x_save;
	} else {
		x_save = x;
	}
	if (y_save != -1) {
		y = y_save;
	} else {
		y_save = y;
	}

	
	x += choose(-1, 1) * irandom_range(0.5,1);
	y += choose(-1, 1) * irandom_range(0.5,1);
} else {
	x_save = -1;
	y_save = -1;
}

if (gamepad_button_check_pressed(device_index, gp_face4)) {
	room_restart();
}
