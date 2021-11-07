/// @desc

levels = [rm_game_1, rm_game_2, rm_game_3, rm_game_4];

active = true;

state = 0;

logo_alpha = 1;

c1 = make_color_rgb(94, 0, 39);
c2 = make_color_rgb(26, 0, 3);

level_offset = 0;

function switch_rooms() {
	switch (cursor) {
		case 1: change_room(rm_game_1); break;
		case 2: change_room(rm_game_2); break;
		case 3: change_room(rm_game_3); break;
		case 4: change_room(rm_game_4); break;
	}
}

cursor = 0;
cursor_2 = 0;
options = [];
function add_option(name, func=function(){}) {
	var o = new option(name, func);
	array_push(options, o);
	return o;
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

add_option("Start", function() {
	state = 1;
	active = false;
});
//add_option("Assist Options");
add_option("Settings", function() {
	var p = pause_game();
	
	if (!instance_exists(p)) return;
	
	with (p) {
		controller = other;
		extra_options = function() {
			add_option("Back", function() {
				unpause_game();
				
				if (instance_exists(controller)) {
					with (controller) {
						alarm_set(0,10);
					}
				}
			});
		}
	}
	active = false;
});
add_option("Quit", function() {
	with (instance_create_depth(0,0,-10000,obj_confirm_modal)) {
		controller = other;
		yes_func = function() {
			save_game();
			game_end();
		}
		no_func = function() {
			if (instance_exists(controller)) {
				with (controller) {
					alarm_set(0,10);
				}
			}
		}
	}
	active = false;
});