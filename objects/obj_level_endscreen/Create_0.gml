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

rm_index = get_room_index();
level_numb = rm_index+1;