/// @desc

surface_resize(application_surface, 320, 180);
display_set_gui_maximize();

randomize();

music_loaded = false;
played_music = false;

audio_group_load(ag_music);
audio_group_load(ag_sounds);

global.audio_gain = ds_map_create();
ds_map_add(global.audio_gain, ag_sounds, 0.5);
ds_map_add(global.audio_gain, ag_music, 0.5);
ds_map_add(global.audio_gain, -1, 0.5);

global.timer_active = true;
global.time                = 0;
global.statistics_jumps    = 0;
global.statistics_dashs    = 0;
global.statistics_falls    = 0;
global.statistics_max_fall = 0;

global.best_time = [-1, -1, -1];

global.music_soundid = -1;

global.show_timer = true;
global.show_progress = true;

global.game_paused = false;
global.can_pause = true;

#macro CAM view_camera[0]
#macro CX camera_get_view_x(CAM)
#macro CY camera_get_view_y(CAM)
#macro CW camera_get_view_width(CAM)
#macro CH camera_get_view_height(CAM)
global.CW_default = 320;
global.CH_default = 180;

global.cur_room = noone;

globalvar device_index;
device_index = 0;

for (var i = 0; i < 5; i ++) {
	if (gamepad_is_connected(i)) {
		device_index = i;
		break;
	}
}



global.gp_vibration = 0;

function get_input() {
	global.key_right = keyboard_check(vk_right);
	global.key_left  = keyboard_check(vk_left);
	global.key_down  = keyboard_check(vk_down);
	global.key_up    = keyboard_check(vk_up);
	global.key_jump  = keyboard_check(ord("Z"));
	global.key_dash  = keyboard_check(ord("X"));
	
	global.key_jump_pressed = keyboard_check_pressed(ord("Z"));
	global.key_dash_pressed = keyboard_check_pressed(ord("X"));
	global.key_right_pressed = keyboard_check_pressed(vk_right);
	global.key_left_pressed  = keyboard_check_pressed(vk_left);
	global.key_up_pressed   = keyboard_check_pressed(vk_up);
	global.key_down_pressed   = keyboard_check_pressed(vk_down);
	global.key_pause_pressed = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_enter);
	global.key_back_pressed = false;
	
	
	if (gamepad_is_connected(device_index)) {
		
		global.key_right |= gamepad_button_check(device_index, gp_padr);
		global.key_left  |= gamepad_button_check(device_index, gp_padl);
		global.key_up    |= gamepad_button_check(device_index, gp_padu);
		global.key_down  |= gamepad_button_check(device_index, gp_padd);
		global.key_jump  |= gamepad_button_check(device_index, gp_face1);
		global.key_dash  |= gamepad_button_check(device_index, gp_face3);
		
		global.key_jump_pressed |= gamepad_button_check_pressed(device_index, gp_face1);
		global.key_dash_pressed |= gamepad_button_check_pressed(device_index, gp_face3);
		global.key_right_pressed|= gamepad_button_check_pressed(device_index, gp_padr);
		global.key_left_pressed |= gamepad_button_check_pressed(device_index, gp_padl);
		global.key_up_pressed   |= gamepad_button_check_pressed(device_index, gp_padu);
		global.key_down_pressed |= gamepad_button_check_pressed(device_index, gp_padd);
		global.key_pause_pressed |= gamepad_button_check_pressed(device_index, gp_start);
		global.key_back_pressed |= gamepad_button_check_pressed(device_index, gp_face2);
	}
}
get_input();

global.debug = 0;
global.camera_lock = true;

draw_set_font(fnt_main)