/// @desc Set fade state and variables

switch (fade_state) {
	// Fade in
	case 0:
		// Increase alpha to full
		alpha = approach(alpha, 1, 1/fade_in_time);
		
		// When fade in is done
		if (alpha == 1) {
			// Go to transition state
			fade_state = 1;
			
		}
		break;
	
	// Transition
	case 1:
		// Alarm has not been set
		if (alarm[0] == -1) {
			// Change rooms
			if (goto_room != -1) {
				room_goto(goto_room);
			}
			
			// Set alarm
			alarm_set(0, fade_trans_time);
		}
		break;
	
	// Fade out
	case 2:
		// Increase alpha to full
		alpha = approach(alpha, 0, 1/fade_out_time);
		
		// When fade in is done
		if (alpha == 0) {
			// Destroy this object
			instance_destroy();
		}
		break;
}