/// @desc

draw_set_font(fnt_pause)

//draw_sprite_stretched(spr_level_clear_bg, 0, x, y, width, height);




draw_rectangle_color(0, 0, room_width, room_height, c1, c1, c2, c2, 0);

draw_sprite_ext(spr_logo, 0, room_width/2, room_height/2-40 + 2*sin(current_time/600), 1, 1, 0, c_white, logo_alpha);

if (state == 0) {
	
	draw_set_halign(fa_center);


	var scale = 1;

	var xx = room_width/2;
	var yy = room_height-62;

	for (var i = 0; i < array_length(options); i ++) {
		var o = options[i];
	
		if (cursor == i) {
			draw_text_transformed(xx-o.width/2, yy, ">", scale, scale, 0);
		}
	
		draw_text_transformed(xx, yy, o.name, scale, scale, 0);
	
		yy += o.height * scale;
	}
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	
	draw_text(2, room_height+2, "Version: 1.1");
	
	draw_set_valign(fa_top);
	
} else {
	var yy = 110;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	for (var i = 0; i < array_length(levels); i ++) {
		var xx = 88*(i);
		draw_sprite(spr_level, cursor==i+1 && state==1, 48 + xx + level_offset, yy);
		draw_text(72 + xx + level_offset, yy + 24, string(i+1));
	}

	draw_set_valign(fa_top);
	
	draw_text(room_width/2, 95, "Level select");
	
	var c = c_white;
	if (cursor == 0 && state==1) {
		c = c_yellow;
	}
	draw_text_color(room_width/2, 160, "Back", c, c, c, c, 1);
	
	if (cursor != 0 && state != 2) {
		val = "N/A";
		if (global.best_time[cursor-1] != -1) {
			val = string(real_to_time(global.best_time[cursor-1]));
		}
		draw_text(room_width-40, 20, "best:" + val);
	}
	
	if (state == 2) {
		draw_set_valign(fa_middle);
		
		draw_text(room_width/2, room_height/2-40, (cursor_2 == 0 ? ">" : " ") + "Continue (" + string(global.current_progress[cursor-1]) + "%, " + string(global.current_time[cursor-1]) + "s)");
		draw_text(room_width/2, room_height/2-20, (cursor_2 == 1 ? ">" : " ") + "Restart");
		
		draw_set_valign(fa_top);
	}
}

draw_set_halign(fa_left);

draw_set_font(fnt_main);