/// @desc

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

if (death_condition()) {
	instance_destroy();
}

if (alpha_decay > 0 && alpha <= 0) {
	instance_destroy();
}

x += hsp;
y += vsp;

hsp = approach(hsp, 0, hsp_decay);
vsp = approach(vsp, 0, vsp_decay);
alpha = approach(alpha, 0, alpha_decay);

step();