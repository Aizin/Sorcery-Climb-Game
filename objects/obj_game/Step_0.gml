/// @desc

if (global.timer_active && !instance_exists(obj_transition)) {
	if (alarm[0] == -1) {
		alarm_set(0, room_speed);
	}
}

if ((((global.key_back_pressed && global.game_paused) || global.key_pause_pressed)) && global.can_pause && !instance_exists(obj_confirm_modal)) {
	
	if (instance_exists(obj_main_menu)) {
		if (!global.game_paused) {
			exit;
		} else {
			with (obj_main_menu) {
				alarm_set(0,10);
			}
			
		}
	}
	
	toggle_pause();
	
	play_sound(snd_menu_select);
}

if (music_loaded && !played_music) {
	played_music = true;
	
	switch (room) {
		case rm_menu:
			play_music(snd_mus_menu);
			break;
		case rm_game_1:
			play_music(snd_music_theme_1);
			break;
		case rm_game_2:
			play_music(snd_music_theme_1);
			break;
		case rm_game_3:
			play_music(snd_music_theme_1);
			break;
	}

}

