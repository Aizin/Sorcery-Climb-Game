/// @desc

repeat (2) {
	var l = instance_create_layer(x,y,"Lighting",obj_moving_light);
	
	with (l) {
		follow = other;
		color = make_color_rgb(0, 119, 255);
		size = 32;
		step = function() {
			str = 0.5 + 0.25*sin(current_time/400);
		}
	}
}