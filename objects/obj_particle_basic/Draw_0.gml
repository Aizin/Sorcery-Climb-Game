/// @desc

draw_set_color(color);
draw_set_alpha(alpha);

draw_rectangle(round(x), round(y), round(x)+width-1, round(y)+height-1, false);

for (var i = 0; i < glow; i ++) {
	draw_set_alpha(glow_alpha * alpha * (1-i/glow));
	var xx = 0;
	var yy = -i;
	draw_rectangle(round(x+xx), round(y+yy), round(x+xx)+width-1, round(y+yy)+height-1, false);
	var xx = 0;
	var yy = i;
	draw_rectangle(round(x+xx), round(y+yy), round(x+xx)+width-1, round(y+yy)+height-1, false);
	var xx = i;
	var yy = 0;
	draw_rectangle(round(x+xx), round(y+yy), round(x+xx)+width-1, round(y+yy)+height-1, false);
	var xx = -i;
	var yy = 0;
	draw_rectangle(round(x+xx), round(y+yy), round(x+xx)+width-1, round(y+yy)+height-1, false);
}

draw_set_color(c_white);
draw_set_alpha(1);