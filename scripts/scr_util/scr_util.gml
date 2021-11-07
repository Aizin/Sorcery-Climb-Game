function approach(val, goal, step) {
	return val < goal ? min(val + step, goal) : max(val - step, goal);
}

function real_to_time(val, mili=true) {

	var mins = 0;
	var secs = 0;
	
	while (val >= 60) {
		val -= 60;
		mins ++;
	}
	secs = val;
	
	if(!mili) {
		secs = floor(secs);
	}
	
	mins = string(mins);
	
	if (mins < 10) {
		mins = "0" + mins;
	}
	
	secs = string(secs);
	
	if (secs < 10) {
		secs = "0" + secs;
	}
	
	return mins + ":" + secs;
}