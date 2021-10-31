/// @desc

// Inherit the parent event
event_inherited();

function press() {
	return keyboard_check(ord("X"));
}

function disabled() {
	if (instance_exists(obj_player)) {
		return !obj_player.can_dash;
	}
	return false;
}

disabled_sprite = spr_key_cap_x_diabled;