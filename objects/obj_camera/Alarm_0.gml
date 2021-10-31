/// @desc

shake_magnitude = lerp(shake_magnitude, 0, 0.2);
shake_x = choose(1,-1) * random_range(shake_magnitude/2, shake_magnitude);
shake_y = choose(1,-1) * random_range(shake_magnitude/2, shake_magnitude);

if (floor(shake_magnitude) != 0) {
	alarm_set(0, shake_buffer);
} else {
	shake_x = 0;
	shake_y = 0;
	shake_magnitude = 0;
}