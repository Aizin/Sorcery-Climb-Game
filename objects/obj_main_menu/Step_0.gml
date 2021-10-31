/// @desc

if (instance_exists(obj_transition)) return;

if (state == 0) {
	if (!active) {
		return;
	}

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
	}
} else {
	if (cursor == 0) {
		if (global.key_jump_pressed) {
			state = 0;
			active = 1;
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
			cursor = approach(cursor, 3, 1);
			play_sound(snd_menu_cursor);
		}
		if (global.key_left_pressed) {
			cursor = approach(cursor, 1, 1);
			play_sound(snd_menu_cursor);
		}
		
		if (global.key_jump_pressed) {
			switch (cursor) {
				case 1: change_room(rm_game_1); break;
				case 2: change_room(rm_game_2); break;
				case 3: change_room(rm_game_3); break;
			}
			play_sound(snd_menu_select);
		}
	}
	
	if (global.key_back_pressed) {
		state = 0;
		active = 1;
		cursor = 0;
		play_sound(snd_menu_select);
	}
}