/// @desc

get_input();

if (gamepad_is_connected(device_index)) {
	gamepad_set_vibration(device_index, global.gp_vibration, global.gp_vibration);
	global.gp_vibration = approach(global.gp_vibration, 0, 0.05);
}