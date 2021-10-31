/// @desc

// Inherit the parent event
event_inherited();

function press() {
	if (gamepad_is_connected(device_index)) {
		return gamepad_button_check(device_index, gp_face1);
	}
	return false;
}