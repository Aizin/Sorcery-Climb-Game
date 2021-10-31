/// @desc

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed_color(x, y, "-" + string(value) + "%", scale, scale, 0, c_white, c_white, c_white, c_white, alpha);
draw_set_halign(fa_left);
draw_set_valign(fa_top);