/// @desc

if (alpha_decay) {
	alpha = approach(alpha, 0, 0.05);
	
	if (alpha == 0) { 
		instance_destroy();
	}
}

y -= 0.25;

scale = lerp(scale, scale_min, 0.3);