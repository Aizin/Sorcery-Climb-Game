/// @desc

// Inherit the parent event
event_inherited();

function press() {
	if (gamepad_is_connected(device_index)) {
		return gamepad_button_check(device_index, gp_face3);
	}
	return false;
}

function disabled() {
	if (instance_exists(obj_player)) {
		return !obj_player.can_dash;
	}
	return false;
}

disabled_sprite = spr_key_gp_x_disabled;