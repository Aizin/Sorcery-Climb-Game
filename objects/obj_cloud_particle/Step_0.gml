/// @desc Move particle

if (step_frequency_current != 0) {
	step_frequency_current = approach(step_frequency_current, 0, 1);
	
	return;
} else {
	step_frequency_current = step_frequency;
}

if (instance_exists(obj_player)) {
	if (obj_player.movement_pause > 0) {
		return;
	}
}

x = xanchor + xamp * sin(timer/timer_spd);
y -= vsp;

radius_percent = approach(radius_percent, 0, choose(0, random(0.2), choose(0, -random(0.015))));

if (radius_percent == 0) {
	instance_destroy();
}

timer ++;

xanchor += xanchor_move;