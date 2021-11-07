
function reset_save_vars(rm_index) {
	global.level_completion[rm_index] = true;
		
	global.statistics_dashs[rm_index] = 0;
	global.statistics_jumps[rm_index] = 0;
	global.statistics_falls[rm_index] = 0;
	global.statistics_max_fall[rm_index] = 0;
		
	global.current_progress[rm_index] = 0;
	global.current_position[rm_index] = [-1,-1];
	global.current_time[rm_index] = 0;
	global.time = 0;
}

function interpret_file(f) {
	global.best_time	    = f.best_time;
	global.current_progress = f.current_progress;
	global.current_position = f.current_position;
	global.level_completion = f.level_completion;
	global.current_time = f.current_time;
	global.statistics_dashs = f.statistics_dashs;
	global.statistics_falls = f.statistics_falls;
	global.statistics_jumps = f.statistics_jumps;
	global.statistics_max_fall = f.statistics_max_fall;
}


function create_default_save_file() {
	save_game();
}

function get_file_name() {
	return "save.azn";
}

function load_file() {
	var filename = get_file_name();
	
	var root_struct = get_file_data(filename);
	
	if (is_undefined(root_struct)) {
		create_default_save_file();
	} else {
		interpret_file(root_struct);
	}
}

function get_file_data(filename) {
	if (!file_exists(filename)) {
		return undefined;
	}
	var json = load_string(filename);
	return json_parse(json);
}

function save_game() {
	global.current_time[get_room_index()] = global.time;
	var root_struct = {
		are_you_trying_to_cheat : "wow... can't even beat the game so you need to cheat......",
		version: 1.1,
		best_time: global.best_time,
		current_progress: global.current_progress,
		current_position: global.current_position,
		level_completion: global.level_completion,
		current_time: global.current_time,
		statistics_dashs: global.statistics_dashs,
		statistics_falls: global.statistics_falls,
		statistics_jumps: global.statistics_jumps,
		statistics_max_fall: global.statistics_max_fall,
	};
	create_save_file(get_file_name(), root_struct);
}

function create_save_file(name, struct) {
	
	// Convert to json
	var json = json_stringify(struct);
	
	// Save file
	save_string(json, name);
}

function save_string(str, filename) {
	// Create buffer
	var buffer = buffer_create(string_byte_length(str) + 1, buffer_fixed, 1);
	
	// Write string to buffer
	buffer_write(buffer, buffer_string, str);
	
	// Save buffer to file
	buffer_save(buffer, filename);
	
	// Delete buffer
	buffer_delete(buffer);
}

function load_string(filename) {
	// Load the file into a buffer
	var buffer = buffer_load(filename);
	
	// Read the buffer
	var str = buffer_read(buffer, buffer_string);
	
	// Delete the buffer
	buffer_delete(buffer);
	
	// Return found string
	return str;
}