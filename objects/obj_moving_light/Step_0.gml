/// @desc

if (instance_exists(follow)) {
	x = follow.x+offset_x;
	y = follow.y+offset_y;
	step()
} else {
	instance_destroy();
}