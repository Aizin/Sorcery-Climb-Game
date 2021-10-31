/// @desc

var sw = 50;
var sh = 50;

if (surface_exists(surf)) {
	surface_set_target(surf)
		
		draw_clear_alpha(c_white, 0);
		
		draw_sprite_ext(sprite_index, image_index, sw/2, sh/2, image_xscale*xscale, image_yscale*yscale, image_angle, image_blend, image_alpha);
		
		if (dashing) {
			gpu_set_colorwriteenable(1,1,1,0);
			
			draw_set_alpha(dash_alpha);
			draw_rectangle_color(0,0,sw,sh,dash_c1,dash_c1,dash_c2,dash_c2,0);
			draw_set_alpha(1);
			
			gpu_set_colorwriteenable(1,1,1,1);
		}
	surface_reset_target();
	
	draw_surface(surf, x-sw/2, y-sh/2);
} else {
	surf = surface_create(sw, sh);
}

//draw_rectangle(CX+10, CY+40, CX+30, CY+60, !dashing);
//draw_text(CX+25, CY+50, hsp)

