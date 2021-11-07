/// @desc

if (instance_exists(obj_transition) || instance_exists(obj_pause_menu)) return;

if (alarm[0] == -1) {
	if (state == 0) {
		if (global.key_down_pressed) {
			cursor = approach(cursor, array_length(options)-1, 1);
		
			while (options[cursor].name == "") {
				cursor = approach(cursor, array_length(options)-1, 1);
			}
		
			play_sound(snd_menu_cursor);
		}
		if (global.key_up_pressed) {
			cursor = approach(cursor, 0, 1);
		
			while (options[cursor].name == "") {
				cursor = approach(cursor, 0, 1);
			}
		
			play_sound(snd_menu_cursor);
		}
	
		if (global.key_jump_pressed) {
			options[cursor].press();
		
			play_sound(snd_menu_select);
			
			alarm_set(0, 5);
		}
	} else if (state == 1) {
		if (cursor == 0) {
			if (global.key_jump_pressed) {
				state = 0;
				alarm_set(0, 5);
				play_sound(snd_menu_select);
			}
			if (global.key_up_pressed || global.key_left_pressed || global.key_right_pressed) {
				cursor = 1;
				play_sound(snd_menu_cursor);
			}
		} else {
			if (global.key_down_pressed) {
				cursor = 0;
				play_sound(snd_menu_cursor);
			}
			if (global.key_right_pressed) {
				cursor = approach(cursor, array_length(levels), 1);
				play_sound(snd_menu_cursor);
			}
			if (global.key_left_pressed) {
				cursor = approach(cursor, 1, 1);
				play_sound(snd_menu_cursor);
			}
		
			if (global.key_jump_pressed) {
				if (global.current_time[cursor-1] == 0) {
					switch_rooms();
				} else {
					state = 2;
					cursor_2 = 0;
					alarm_set(0, 5);
				}
				play_sound(snd_menu_select);
			}
		}
	
		if (global.key_back_pressed) {
			state = 0;
			cursor = 0;
			play_sound(snd_menu_select);
			alarm_set(0, 5);
		}
	} else {
		if (global.key_back_pressed) {
			state = 1;
			cursor_2 = 0;
			play_sound(snd_menu_select);
			alarm_set(0, 5);
		}
	
		if (global.key_down_pressed) {
			if (cursor_2 == 1) {
				state = 1;
				cursor_2 = 0;
			} else {
				cursor_2 = 1;
			}
			play_sound(snd_menu_cursor);
		}
		if (global.key_up_pressed) {
			cursor_2 = 0;
			play_sound(snd_menu_cursor);
		}
	
		if (global.key_jump_pressed) {
			// Restart
			if (cursor_2 == 1) {
				reset_save_vars(cursor-1);
			}
		
			switch_rooms();
		
			alarm_set(0, 5);
			play_sound(snd_menu_cursor);
		}
	}
}

level_offset = lerp(level_offset, -(max(cursor,1)-2)*88, 0.2);

logo_alpha = approach(logo_alpha, state != 2, 0.1);