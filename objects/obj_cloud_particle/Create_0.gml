/// @desc Init variables

timer = 0;
timer_spd = random_range(5, 10);

xanchor = xstart;
xanchor_move = choose(-1, 0, 0, 1) * random(0.3);

xamp = random_range(3, 6);
vsp = random_range(0.4, 0.95);

radius_percent = 1;

function blob() constructor {
	main = other;
	
	offset_x = choose(-1, 1) * random(5);
	offset_y = choose(-1, 1) * random(5);
	radius = random_range(1, 4);
	circle_precision = 4 * irandom_range(2, 4); // Must be divisible by 4
	
	function draw() {
		draw_set_circle_precision(circle_precision);
		draw_circle(main.x + offset_x * max(main.radius_percent, 0.5), 
		main.y + offset_y * max(main.radius_percent, 0.5), 
		radius * main.radius_percent, 0);
		draw_set_circle_precision(24);
	}
}

blob_count = irandom_range(1, 3);
blobs = [];
for (var i = 0; i < blob_count; i ++) {
	array_push(blobs, new blob());
}


function draw() {
	for (var i = 0; i < blob_count; i ++) {
		blobs[i].draw();
	}
}

step_frequency = 3;
step_frequency_current = 0;