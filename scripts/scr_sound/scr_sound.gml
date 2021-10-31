
function play_sound(soundid) {
	var s = audio_play_sound(soundid, 0, 0);
	
	sound_set_gain(soundid, 1, 0);
	
	return s;
}

function sound_set_gain(index, vol, time, ag=ag_sounds) {
	audio_sound_gain(index, vol * global.audio_gain[? ag]*global.audio_gain[? -1], time);
}

function play_sound_variation(soundid, mag) {
	var s = play_sound(soundid);
	
	audio_sound_pitch(s, 1 + random_range(-mag,mag));
	
	return s;
}

function play_music(soundid) {
	audio_stop_sound(global.music_soundid);
	
	global.music_soundid = soundid;
	
	var s = audio_play_sound(soundid, 0, 1);
	
	sound_set_gain(soundid, global.audio_gain[? ag_music], 0, ag_music);
	
	return s;
}