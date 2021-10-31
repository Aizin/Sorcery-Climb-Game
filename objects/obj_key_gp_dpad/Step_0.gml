/// @desc

if (!gamepad_is_connected(device_index)) return;

left  = gamepad_button_check(device_index, gp_padl);
right = gamepad_button_check(device_index, gp_padr);
up    = gamepad_button_check(device_index, gp_padu);
down  = gamepad_button_check(device_index, gp_padd);