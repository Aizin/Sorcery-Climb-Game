
function change_room(rm=-1) {
	with (instance_create_depth(0,0,-10,obj_transition)) {
		goto_room = rm;

	}
}

function get_progress() {
	if (instance_exists(obj_progress_controller)) {
		return round(obj_progress_controller.progress);
	}
}

function shake_camera(str) {
	if (instance_exists(obj_camera)) {
		with (obj_camera) {
			shake_magnitude = str;
			alarm_set(0, shake_buffer);
		}
	}
	
}

function rumble(str) {
	if (gamepad_is_connected(device_index)) {
		global.gp_vibration = str;
	}
}

function unpause_game() {
	if (instance_exists(obj_pause_menu)) {
		global.game_paused = false;
		global.timer_active = true;
		with (obj_pause_menu) {
			instance_destroy();
		}
	}
}

function pause_game() {
	if (!instance_exists(obj_pause_menu)){
		global.game_paused = true;
		global.timer_active = false;
		return instance_create_layer(0,0,"Game",obj_pause_menu);
	}
	return noone;
}

function toggle_pause() {
	if (instance_exists(obj_pause_menu)) {
		unpause_game();
		return 0;
	} else {
		pause_game();
		return 1;
	}
}

function get_room_index() {
	switch (room) {
		case rm_game_1: return 0; break;
		case rm_game_2: return 1; break;
		case rm_game_3: return 2; break;
		case rm_game_4: return 3; break;
	}
	return 0;
}