/// @desc

if (instance_exists(target)) {
	var val = clamp(1-target.y/room_height, 0, 1) * 100;
	progress = val;
}

if (instance_exists(obj_level_endscreen)) {
	alpha = approach(alpha, 0, 0.1);
} else {
	alpha = approach(alpha, 1, 0.1);
}