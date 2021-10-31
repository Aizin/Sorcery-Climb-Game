/// @desc

if (stat_state == clamp(stat_state, 0, array_length(stats)-1)) {
	var goal = 0;
	switch (stat_state) {
		case 0: goal = global.time; break;
		case 1: goal = global.statistics_falls; break;
		case 2: goal = global.statistics_jumps; break;
		case 3: goal = global.statistics_max_fall; break;
	}
	stats[stat_state] = ceil(lerp(stats[stat_state],goal,global.key_jump ? 0.1 : 0.01));
	
	if (stats[stat_state] == goal) {
		if (alarm[0] == -1) {
			alarm_set(0, global.key_jump ? 20 : 45);
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
		
		switch (room) {
			case rm_game_1: 
				if (global.best_time[0] == -1) {
					global.best_time[0] = global.time;
				} else {
					global.best_time[0] = min(global.best_time[0], global.time);
				}
				break;
			case rm_game_2: 
				if (global.best_time[1] == -1) {
					global.best_time[1] = global.time;
				} else {
					global.best_time[1] = min(global.best_time[1], global.time);
				}
				break;
			case rm_game_3: 
				if (global.best_time[2] == -1) {
					global.best_time[2] = global.time;
				} else {
					global.best_time[2] = min(global.best_time[2], global.time);
				}
				break;
		}
		
		with (instance_create_layer(0,0,"Game",obj_transition)) {
			switch (room) {
				case rm_game_1: goto_room = rm_game_2; break;
				case rm_game_2: goto_room = rm_game_3; break;
				case rm_game_3: goto_room = rm_menu; break;
				default: goto_room = rm_menu; break;
			}
		}
		
		play_sound(snd_menu_select);
	}
}