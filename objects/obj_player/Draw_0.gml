/// @desc

var sw = 50;
var sh = 50;


if (surface_exists(surf)) {
	surface_set_target(surf)
		
		draw_clear_alpha(c_white, 0);
		
		draw_sprite_ext(sprite_index, image_index, sw/2, sh/2, image_xscale*xscale, image_yscale*yscale, image_angle, image_blend, image_alpha);
		
		if (blue_alpha > 0) {
			var b_spr = get_sprite_blue();
			
			if (b_spr != -1) {
				draw_sprite_ext(b_spr, image_index, sw/2, sh/2, image_xscale*xscale, image_yscale*yscale, image_angle, image_blend, blue_alpha);
			}
		}
		
		if (dashing) {
			gpu_set_colorwriteenable(1,1,1,0);
			
			var c1 = dash_c1;
			var c2 = dash_c2;
			if (blue) {
				var c1 = dash_c1_blue;
				var c2 = dash_c2_blue;
			}
			
			draw_set_alpha(dash_alpha);
			draw_rectangle_color(0,0,sw,sh,c1,c1,c2,c2,0);
			draw_set_alpha(1);
			
			gpu_set_colorwriteenable(1,1,1,1);
		}
		
		
	
	surface_reset_target();
	
	draw_surface(surf, x-sw/2, y-sh/2);
} else {
	surf = surface_create(sw, sh);
}