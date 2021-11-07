/// @desc



draw_set_alpha(alpha);

var yy = CY+10;

if (global.show_progress) {
	draw_text(CX+10, yy, string(round(progress)) + "%");
	
	yy += string_height("A");
}

if (global.show_timer) {
	draw_text(CX+10, yy, real_to_time(global.time, 0));
	yy += string_height("A");
}

draw_set_alpha(1);