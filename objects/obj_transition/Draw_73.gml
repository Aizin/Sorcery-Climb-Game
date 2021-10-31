/// @desc Draw overlay

if (!surface_exists(surf))
{
	surf = surface_create(global.CW_default,CH);
}
else
{
	surface_set_target(surf);
		
		// Clear surface
		draw_clear_alpha(c_black, 0);
		
		// Draw black rectangle over screen
		draw_set_color(c_black);
		draw_rectangle(0, 0, global.CW_default, global.CH_default, false);
		
		// Reset draw alpha
		draw_set_alpha(1);
		
		if (alpha != 1)
		{
			// Start subtracting from the black rectangle over the screen
			gpu_set_blendmode(bm_subtract);
				draw_circle(global.CW_default/2, global.CH_default/2, (1-alpha) * global.CW_default, 0)
			gpu_set_blendmode(bm_normal);
		}
		
	surface_reset_target();
	
	draw_surface(surf, CX, CY);
}



// Reset draw attributes
draw_set_color(c_white);
draw_set_alpha(1);