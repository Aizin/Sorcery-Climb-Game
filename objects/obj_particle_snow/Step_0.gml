/// @desc

xanchor += xanchor_dir * 0.1;

x = xanchor + amp * sin(timer/timer_spd);
y += vsp;

timer ++;

if (y > CY + CH + 30) {
	instance_destroy();
}