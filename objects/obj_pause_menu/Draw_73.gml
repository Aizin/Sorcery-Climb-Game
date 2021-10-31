/// @desc

draw_set_color(c_black);
draw_set_alpha(0.2);
draw_rectangle(CX, CY, CX+CW, CY+CH, false);
draw_set_alpha(1);
draw_set_color(c_white);

draw_set_font(fnt_pause)

draw_sprite_stretched(spr_level_clear_bg, 0, x, y, width, height);

var xx = x+20;
var yy = y+10;
var scale = 1;
for (var i = 0; i < array_length(options); i ++) {
	var o = options[i];
	
	if (cursor == i) {
		draw_text_transformed(x+10, yy, ">", scale, scale, 0);
	}
	
	draw_text_transformed(xx, yy, o.name, scale, scale, 0);
	
	yy += o.height * scale;
}

draw_set_font(fnt_main);