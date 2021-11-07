/// @desc

var fader_spr = sprite_index;
if (blue) {
	fader_spr = get_sprite_blue();
}

with (instance_create_depth(x, y, depth+1, obj_sprite_fader)) {
	sprite_index = fader_spr;
	image_index = other.image_index;
	image_alpha = 0.5 - (other.sprite_fader_count_default - other.sprite_fader_count)*0.1;
	image_xscale = other.image_xscale * other.xscale;
	image_yscale = other.image_yscale * other.yscale;
	
	alpha_spd = 0.02;
}

repeat(irandom_range(2,3)) {
	with (instance_create_depth(x + random_range(-3, 3), y + random_range(-3, 3), depth-10, obj_particle_basic)) {
		
		if (other.part_color == -1) {
			if (other.blue) {
				color = choose(make_color_rgb(0,122,255), make_color_rgb(0, 57, 135));
			} else {
				color = merge_color(make_color_rgb(227, 27, 72), choose(c_white, c_purple, c_blue), choose(random(0.1), random(0.2), random(0.45)));
			}
		} else if (other.part_color == c_green) {
			color = choose(make_color_rgb(9,153,17), make_color_rgb(48, 221, 93), make_color_rgb(136, 251, 155))
		} else {
			color = choose(make_color_rgb(0,122,255), make_color_rgb(0, 57, 135));
		}
		
		alpha_decay = 0.03;
			
		hsp_base = -other.hsp/5 + random(1);
		vsp = -other.vsp/5 + random(1);
			
		step_frequency = 4;
			
		step = function() {
			hsp = choose(0, 0, hsp_base);
				
			if (hsp == hsp_base) {
				hsp_base *= 0.99;
			}
			vsp *= 0.97;
			
			alpha_decay = approach(alpha_decay, 0.1, 0.005);
		}
		
		glow = choose(irandom(2), irandom(3), irandom(3));
		glow_alpha = random_range(0.3,0.8);
		
		var l = instance_create_layer(x,y,"Lighting",obj_moving_light);
		l.follow = self;
		l.color = color;
		l.size = 5;
		with (l) {
			step = function() {
				str = follow.alpha-1;
			}
		}
	}
}

if (sprite_fader_count > 0) {
	alarm_set(0, sprite_fader_spacing);
	sprite_fader_count --;
} else {
	sprite_fader_count = sprite_fader_count_default;
}