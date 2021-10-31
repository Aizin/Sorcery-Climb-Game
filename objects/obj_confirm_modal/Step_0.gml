/// @desc


if (global.key_left_pressed || global.key_right_pressed) {
	cursor = !cursor;
	
	play_sound(snd_menu_cursor);
}

if (global.key_jump_pressed) {
	if (cursor) {
		yes_func();
	} else {
		no_func();
	}
	
	play_sound(snd_menu_select);
	
	destroy();
	on_destroy();
}