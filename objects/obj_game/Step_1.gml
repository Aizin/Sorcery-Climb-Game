/// @desc

get_input();

if (gamepad_is_connected(device_index)) {
	var v = global.gp_vibration * global.controller_rumble;
	gamepad_set_vibration(device_index, v, v);
	global.gp_vibration = approach(global.gp_vibration, 0, 0.05);
}