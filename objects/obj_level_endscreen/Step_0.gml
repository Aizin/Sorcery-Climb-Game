/// @desc

if (stat_state == clamp(stat_state, 0, array_length(stats)-1)) {
	var goal = 0;
	var rm_i = get_room_index();
	switch (stat_state) {
		case 0: goal = global.time; break;
		case 1: goal = global.statistics_falls[rm_i]; break;
		case 2: goal = global.statistics_jumps[rm_i]; break;
		case 3: goal = global.statistics_max_fall[rm_i]; break;
	}
	stats[stat_state] = lerp(stats[stat_state],goal,global.key_jump ? 0.1 : 0.04);
	
	
	if (round(goal) == goal) {
		stats[stat_state] = ceil(stats[stat_state]);
	}
	
	if (abs(stats[stat_state] - goal) < 0.5) {
		if (alarm[0] == -1) {
			stats[stat_state] = goal;
			alarm_set(0, global.key_jump ? 10 : 40);
		}
	} else {
		if (alarm[1] == -1) {
			alarm_set(1, choose(3,irandom_range(2,4)));
		}
	}
}

alpha = approach(alpha, 1, 0.05);

if (global.key_jump_pressed && !instance_exists(obj_transition)) {
	if (stat_state == array_length(stats)) {
		
		if (global.best_time[rm_index] == -1) {
			global.best_time[rm_index] = global.time;
		} else {
			global.best_time[rm_index] = min(global.best_time[rm_index], global.time);
		}
		
		reset_save_vars(rm_index);
		
		with (instance_create_layer(0,0,"Game",obj_transition)) {
			switch (room) {
				case rm_game_1: goto_room = rm_game_2; break;
				case rm_game_2: goto_room = rm_game_3; break;
				case rm_game_3: goto_room = rm_game_4; break;
				case rm_game_4: goto_room = rm_menu; break;
				default: goto_room = rm_menu; break;
			}
		}
		
		save_game();
		
		play_sound(snd_menu_select);
	}
}