/// @desc


cursor_active = true;

height = global.CH_default - 16;
width = height;

x = CX + CW/2 - width/2;
y = CY + CH/2 - height/2;

depth -= 1000;

cursor = 0;
options = [];
function add_option(name, func=function(){}) {
	var o = new option(name, func);
	array_push(options, o);
	return o;
}

function add_option_toggle(name, global_var_) {
	var o = add_option(name);
	with (o) {
		name_save = name;
		global_var = global_var_;
		
		toggle = variable_global_get(global_var);
		
		press = function() {
			toggle = !toggle;
			reset_name();
			
			variable_global_set(global_var, toggle);
		}
		
		reset_name = function() {
			var check = toggle ? "X" : "  ";
			name = name_save + " [" + check + "]";
		}
		
		reset_name();
	}
}
function add_option_slider(name, ag_, move_) {
	var o = add_option(name);
	with (o) {
		name_save = name;
		move = move_;
		ag = ag_;
		
		val_min = 0;
		val_max = 10;
		val = global.audio_gain[? ag] * val_max;
		
		step = function() {
			if (global.key_left_pressed) {
				val = approach(val, val_min, 1);
				move(val);
				reset_name();
				change_vol();
				play_sound(snd_menu_cursor);
			}
			if (global.key_right_pressed) {
				val = approach(val, val_max, 1);
				move(val);
				reset_name();
				change_vol();
				play_sound(snd_menu_cursor);
				
			}
		}
		
		change_vol = function() {
			var new_val = val/val_max;
			
			if (ag == -1) {
				global.audio_gain[? -1] = new_val;
				
				audio_group_set_gain(ag_sounds, global.audio_gain[? ag_sounds]*new_val, 100);
				audio_group_set_gain(ag_music, global.audio_gain[? ag_music]*new_val, 100);
			} else {
				global.audio_gain[? ag] = new_val;
				audio_group_set_gain(ag, new_val*global.audio_gain[? -1], 100);
			}
		};
		reset_name = function() {
			var val_str = "";
			repeat(val) {
				val_str += "-";
			}
			val_str += "0";
			repeat(val_max-val) {
				val_str += "-";
			}
			name = name_save + "  " + val_str;
		}
		
		reset_name();
	}
}

function option(name_, func_) constructor {
	name = name_;
	press = func_;
	
	width = string_width(name);
	height = string_height(name) - 4;
	
	function set_height(h) {
		height = h;
		return self;
	}
	
	step = function() {}
}

add_option_slider("Music", ag_music, function(val){});
add_option_slider("Sound", ag_sounds, function(val){});
add_option_slider("Master", -1 , function(val){});
add_option("")
	.set_height(8);
add_option_toggle("Show Progress", "show_progress")
add_option_toggle("Show Timer", "show_timer")
add_option("")
	.set_height(8);
	
init = false;

function extra_options() {
	add_option("Restart Level", function() {
		with (instance_create_depth(0,0,depth-100,obj_confirm_modal)) {
			controller = other;
			yes_func = function() {
				change_room(room);
			}
			no_func = function() {
				if (instance_exists(controller)) {
					with (controller) {
						alarm_set(0, 10);
					}
				}
			}
		}
		cursor_active = false;
	});
	add_option("Quit", function() {
		with (instance_create_depth(0,0,depth-100,obj_confirm_modal)) {
			controller = other;
			yes_func = function() {
				change_room(rm_menu);
			}
			no_func = function() {
				if (instance_exists(controller)) {
					with (controller) {
						alarm_set(0, 10);
					}
				}
			}
		}
		cursor_active = false;
	});
}

