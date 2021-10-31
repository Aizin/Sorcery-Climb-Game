/// @desc

if (alpha_state) {
	alpha = approach(alpha, 0, 0.07);
	
	if (alpha == 0) {
		instance_destroy();
	}
}

vsp += 0.15;

x += hsp;
y += vsp;