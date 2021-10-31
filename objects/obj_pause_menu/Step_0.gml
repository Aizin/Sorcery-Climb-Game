/// @desc

if (!init) {
	init = true;
	
	extra_options();
}

if (cursor_active) {
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

	options[cursor].step();
}