/// @desc

draw_set_font(fnt_pause)

//draw_sprite_stretched(spr_level_clear_bg, 0, x, y, width, height);




draw_rectangle_color(0, 0, room_width, room_height, c1, c1, c2, c2, 0);

draw_sprite(spr_logo, 0, room_width/2, room_height/2-40 + 2*sin(current_time/600));

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
	
	
	
} else {
	var yy = 110;
	draw_sprite(spr_level, cursor==1, 48, yy);
	draw_sprite(spr_level, cursor==2, 136, yy);
	draw_sprite(spr_level, cursor==3, 224, yy);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text(48 + 24, yy + 24, "1");
	draw_text(136 + 24, yy + 24, "2");
	draw_text(224 + 24, yy + 24, "3");
	
	draw_set_valign(fa_top);
	
	draw_text(room_width/2, 95, "Level select");
	
	var c = c_white;
	if (cursor == 0) {
		c = c_yellow;
	}
	draw_text_color(room_width/2, 160, "Back", c, c, c, c, 1);
	
	if (cursor != 0) {
		val = "N/A";
		if (global.best_time[cursor-1] != -1) {
			val = string(real_to_time(global.best_time[cursor-1]));
		}
		draw_text(room_width-40, 20, "Best time:\n" + val);
	}
}

draw_set_halign(fa_left);

draw_set_font(fnt_main);