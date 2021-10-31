/// @desc

draw_set_alpha(alpha*0.5);

draw_rectangle_color(CX,CY,CX+CW,CY+CH,c_black,c_black,c_black,c_black,0);

draw_set_alpha(1);

draw_sprite_stretched(spr_level_clear_bg, 0, x, y, width, height);

var xx = x+10;
var yy = y+6;
var th = string_height("A");

draw_set_halign(fa_center);
draw_text(CX + CW/2, yy, "Level " + string(level_numb) + " Cleared!");

yy += th;

draw_set_halign(fa_left);
draw_text(xx, yy, "Time: " + string(real_to_time(stats[0])));		yy += th;
draw_text(xx, yy, "Falls: " + string(stats[1]));	yy += th;
draw_text(xx, yy, "Jumps: " + string(stats[2]));	yy += th;
draw_text(xx, yy, "Longest fall: " + string(stats[3]) + "%");	yy += th;

if (stat_state == array_length(stats)) {
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	draw_text(x+width-12 + 3*sin(current_time/300), y+height-5, ">");
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}