/// @desc

draw_set_alpha(0.35);
draw_set_color(c_black);
draw_rectangle(CX,CY,CX+CW,CY+CH,0);
draw_set_alpha(1);
draw_set_color(c_white);

var xx = CX + CW/2 - width/2;
var yy = CY + CH/2 - height/2;

var x_mid = xx + width/2;
var y_mid = yy + height/2;

draw_sprite_stretched(spr_level_clear_bg, 0, xx, yy, width, height);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(x_mid, yy+30, "Are you sure?");

draw_text(x_mid-30, y_mid+10, "No");
draw_text(x_mid+30, y_mid+10, "Yes");

draw_text(x_mid-30 + cursor*60 - 20, y_mid+10, ">");

draw_set_halign(fa_left);
draw_set_valign(fa_top);