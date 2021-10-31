/// @desc


draw_self();

var y_mid = floor(y) + floor(sprite_height/2);
var x_mid = floor(x) + floor(sprite_width/2);

draw_sprite(spr_key_gp_left , left,  bbox_left, y_mid);
draw_sprite(spr_key_gp_right, right, bbox_right, y_mid);
draw_sprite(spr_key_gp_up   , up,    x_mid, bbox_top);
draw_sprite(spr_key_gp_down , down,  x_mid, bbox_bottom);