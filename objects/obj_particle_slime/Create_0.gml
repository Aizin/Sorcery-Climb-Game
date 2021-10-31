/// @desc

color = make_color_rgb(220, 31, 171);

hsp = 0;
vsp = 0;

alpha = 1;
alpha_state = 0;

alarm_set(0, irandom_range(10, 30));

function draw() {
	draw_set_color(color);
	draw_set_alpha(alpha);

	draw_rectangle(round(x), round(y), round(x)+size-1, round(y)+size-1, false);

	draw_set_alpha(1);
	draw_set_color(c_white);
}