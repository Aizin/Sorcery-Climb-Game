/// @desc

global.timer_active = false;

stat_state = -1;
stats = array_create(4, 0);

alarm_set(0, 30);

alpha = 0;

width = global.CW_default - 32*2;
height = global.CH_default - 32*2;

x = CX + CW/2 - width/2;
y = CY + CH/2 - height/2;

level_numb = 1;
switch (room) {
	case rm_game_1: level_numb = 1; break;
	case rm_game_2: level_numb = 2; break;
	case rm_game_3: level_numb = 3; break;
}