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

dash_alpha = approach(dash_alpha, dashing ? 0.12 : 0, 0.02);
horizontal_lock = approach(horizontal_lock, 0, 1);

