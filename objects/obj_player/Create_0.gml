/// @desc

rm_index = get_room_index();
if (global.current_position[rm_index, 0] != -1) {
	x = global.current_position[rm_index, 0];
}
if (global.current_position[rm_index, 1] != -1) {
	y = global.current_position[rm_index, 1];
}

dash_alpha = 0;
dash_c1 = make_color_rgb(255, 58, 162);
dash_c2 = make_color_rgb(169, 16, 177);
dash_c1_blue = make_color_rgb(0, 122, 255);
dash_c2_blue = make_color_rgb(0, 54, 153);

horizontal_lock = 0;

part_color = -1;

repeat (2) {
	var l = instance_create_layer(x,y,"Lighting",obj_moving_light);
	l.offset_y = -5;
	
	with (l) {
		step = function() {
			if (follow.dashing) {
				size = lerp(size, 0, 0.1);
			} else {
				size = lerp(size, 64, 0.1);
			}
		}
	}
}

blue = false;
blue_alpha = 0;

surf = -1;

xscale = 1;
yscale = 1;

down = false;
down_timer = 60;

spd = 1.5;
hsp = 0;
vsp = 0;
jump_spd = 4;
dash_vsp = 4;
bounce_vsp = 4;

hsp_carry = 0;
vsp_carry = 0;

grav = 0.3;
fric = 0.25;

dir = 1;

jump_buffer = 0;
jump_buffer_timer = 10;

onground_previous = false;
progress_previous = 0;

xaxis = 0;

movement_pause = 0;

dashing = false;
dashing_pause = 7;
dashing_pause_end = false;

sprite_fader_count_default = 3;
sprite_fader_spacing = 5;
sprite_fader_count = sprite_fader_count_default;

debug_movement = false;

can_dash = false;

touching_gem = false;
touching_gem_blue = false;

blue_grounded = false;

function process_movement() {
	
	
	
	if (global.debug && debug_movement) {
		x += (global.key_right - global.key_left) * 7;
		y += (global.key_down - global.key_up) * 7;
		return;
	}
	
	can_dash = false;
	
	if (!dashing && horizontal_lock == 0) {
		xaxis = global.key_right - global.key_left;
	
		if (global.key_right) {
			hsp = approach(hsp, spd, fric);
			dir = 1;
			global.timer_active = 1;
		}
		if (global.key_left) {
			hsp = approach(hsp, -spd, fric);
			dir = -1;
			global.timer_active = 1;
		}
		if (xaxis == 0) {
			hsp = approach(hsp, 0, fric);
		}
	}
	
	if (place_meeting(x,y+1,obj_wall)) {
		onground_previous = false;
		
		horizontal_lock = 0;
		
		jump_buffer = jump_buffer_timer;
		
		
		
		
		var w = instance_place(x,y+1,obj_wall);
		if (w.slope) {
			dashing = true;
		} else {
			dashing = false;
		}
		
		if (!dashing && blue && !blue_grounded) {
			vsp = -jump_spd * 3/2;
			hsp = hsp/1.5 + dir;
			dashing = true;
			movement_pause = dashing_pause*2;
			xscale = 1.5;
			yscale = 0.5;
			horizontal_lock = 10;
			blue_grounded = true;
		}
		
		if (!dashing) {
			global.current_position[rm_index, 0] = x;
			global.current_position[rm_index, 1] = y;
			global.current_progress[rm_index] = get_progress();
		}
		
	} else {
		if (!onground_previous) {
			onground_previous = true;
			
			if (!dashing) {
				progress_previous = get_progress();
			}
		}
		
		if (movement_pause == 0) {
			vsp += grav;
		}
		
		if (!dashing) {
			can_dash = true;
			if (global.key_dash_pressed) {
				
				global.statistics_dashs[rm_index] ++;
				
				dashing = true;
				dash_alpha = 0.6;
				movement_pause = dashing_pause;
				dashing_pause_end = true;
				vsp = -dash_vsp;
				hsp = hsp/1.5 + dir;
				
				xscale = 0.5;
				yscale = 1.5;
				
				part_color = -1;
			}
		}
		
		if (instance_exists(obj_gem_1)) {
			if (place_meeting(x,y,obj_gem_1)) {
				var g = instance_place(x,y,obj_gem_1);
				if (!touching_gem) {
					touching_gem = true;
					
					dashing = true;
					
					hsp = dir * (spd+0.5);
					vsp = -jump_spd*1.2;
					
					movement_pause = dashing_pause;
					dashing_pause_end = true;
					
					xscale = 0.5;
					yscale = 1.5;
					
					shake_camera(2);
					rumble(0.2);
					
					if (g.refill) {
						dashing = false;
						
						horizontal_lock = 8;
						
						part_color = c_green;
						
						alarm_set(2, 50);
					} else {
						part_color = -1;
					}
					
					play_sound(snd_gem_1);
				}
			} else {
				touching_gem = false;
				
			}
		}
		
		if (instance_exists(obj_gem_blue)) {
			if (place_meeting(x,y,obj_gem_blue)) {
				var g = instance_place(x,y,obj_gem_blue);
				if (!touching_gem_blue) {
					shake_camera(2);
					rumble(0.2);
					
					touching_gem_blue = true;
					blue = true;
					play_sound(snd_gem_blue);
					
					repeat (10) {
						var angle = random_range(0, 360);
						var xx = 5 * dcos(angle);
						var yy = 5 * -dsin(angle);
						with (instance_create_depth(g.x+xx, g.y+yy, depth-10, obj_particle_basic)) {
							var spd_ = 1.5;
							hsp = spd_ * dcos(angle);
							vsp = spd_ * -dsin(angle);
			
							alpha_decay = 0.1;
				
							step_frequency = (other.movement_pause/other.dashing_pause)*3+1;
							color = make_color_rgb(0, 166, 255);
				
							var l = instance_create_layer(x,y,"Lighting",obj_moving_light);
							l.follow = self;
							l.color = color;
							l.size = 2
							with (l) {
								step = function() {
									str -= 0.3;
								}
							}
						}
					}
				}
			} else {
				touching_gem_blue = false;
			}
		}
		
		jump_buffer = approach(jump_buffer, 0, 1);
	}
	
	
	if (!dashing && !blue_grounded) {
		if (global.key_jump_pressed && jump_buffer != 0) {
			vsp = -jump_spd;
			
			global.statistics_jumps[rm_index] ++;
			
			jump_buffer = 0;
			
			xscale = 0.5;
			yscale = 1.5;
			
			play_sound(snd_jump);
			
			global.timer_active = 1;
		}
		
		
	}
	
	process_collision();
	
	if (movement_pause == 0) {
		
		if (dashing_pause_end) {
			dashing_pause_end = false;
			create_dash_particles();
			
			var s = play_sound_variation(snd_dash, 0.1);
			var t = max(abs(hsp) + min(abs(vsp)/8,3), 0.5)*230;
			sound_set_gain(s, 0, t);
			
			shake_camera(3);
			rumble(0.8);
			
			alarm_set(0, sprite_fader_spacing);
		}
		
		if (blue_grounded) {
			blue = false;
			blue_grounded = false;
			
			alarm_set(0, sprite_fader_spacing);
			
			part_color = c_blue;
			
			play_sound(snd_blue_jump);
						
			alarm_set(2, 50);
			
			shake_camera(3);
			rumble(0.5);
		}
	} else {
		movement_pause = approach(movement_pause, 0, 1);
	}
}


test = 0;

function process_collision() {
	//Offsets
	var sprite_bbox_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);
	var sprite_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);
	var sprite_bbox_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
	var sprite_bbox_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);

	var hsp_final = hsp + hsp_carry;
	hsp_carry = 0;

	if (movement_pause == 0) {
		// Horizontal collisions
		x += hsp_final;
	}

	var slope_used = false;

	// Snap Horizontally

	// If about to touch wall horizontally
	if place_meeting(x+sign(hsp_final),y,obj_wall) {
	
		// Get wall instance
		var wall = instance_place(x+sign(hsp_final),y,obj_wall);
	
		// Make sure wall is active
		if (wall.active) {
		
			// Find free y pos on slope
			var y_plus = 0;
			var slope_tolerance = 4;
			while (place_meeting(x+hsp_final, y-y_plus, obj_wall) && y_plus <= slope_tolerance) {
				y_plus ++;
			}
	
			// Determine if we move up slope
			if (!place_meeting(x+hsp_final,y-y_plus,obj_wall)) {
			
				// Move up slope
				y -= y_plus;
				slope_used = true;
			} else {
			
				var cond = hsp_final > 0;
				
				if (wall.hsp < 0) {
					cond = !cond;
				}
				
				// Determine which side wall is on
				if (cond) { 
					// Right
				
					// Snap
				    x = (wall.bbox_left-1)-sprite_bbox_right;
				} else if (hsp_final < 0) { 
					// Left
				
					// Snap
				    x = (wall.bbox_right+1)-sprite_bbox_left;
				}
			
				if (dashing) {
					
					var dampen = wall.dampen;
					
					if (audio_is_playing(snd_dash)) {
						sound_set_gain(snd_dash,0,100);
					}
					
					if (wall.bounce) {
						
						vsp = -bounce_vsp;
						
						repeat(irandom_range(4,7)) {
							with (instance_create_depth(x,y,depth+1,obj_particle_slime)) {
								size = choose(1,1,2);
								hsp = -other.dir * random_range(0.1,0.4);
								vsp = -random_range(0.8,2);
								color = wall.color;
							}
						}
						
						play_sound_variation(snd_bounce, 0.1);
					}
					
					if (wall.refill) {
						dashing = false;
						
						horizontal_lock = 8;
					}
					
					play_sound_variation(snd_hit_wall, 0.1);
					
					hsp *= -1 * dampen;
					
					dir *= -1;
					movement_pause = 2;
					
					
					
					shake_camera(1.5);
					
					
					xscale = 0.5;
					yscale = 1.5;
				} else {
					// Stop moving horizontally
					hsp = 0;
				}
			}
		}
	}

	// Move down slope
	if (!place_meeting(x, y, obj_wall) && vsp >= 0 && place_meeting(x, y+2+abs(hsp), obj_wall)) {
		while (!place_meeting(x, y+1, obj_wall)) {
			y ++;
		}
	}
	
	

	var vsp_final = vsp + vsp_carry;
	vsp_carry = 0;
	
	if (dashing && place_meeting(x,y+1,obj_wall)) {
	
		// Get wall instance
		var wall = instance_place(x,y+1,obj_wall);
		
		if (wall.slope) {
			
			vsp += grav;
			vsp_final += grav;
			hsp = 2 * sign(wall.dir);
			
			test = 1;
			
			if (!place_meeting(x, y, obj_wall) && vsp >= 0 && place_meeting(x, y+2+abs(hsp), obj_wall)) {
				while (!place_meeting(x, y+1, obj_wall)) {
					y ++;
				}
			}
		}
	}

	// Vertical collisions

	// If we are about to touch a wall
	if (place_meeting(x,y+vsp_final,obj_wall)) {
	
		// Get wall instance
		var wall = instance_place(x,y+vsp_final,obj_wall);
	
		if (wall.active) {
		
			// Round of y pos
			y = round(y);
		
			// Move out of the wall
			while (!place_meeting(x,y+sign(vsp_final),obj_wall)) {
				y += sign(vsp_final);
			}
		
			// Determine which side wall is on
			if (vsp_final > 0) { 
				// Bottom
				
				if (!wall.slope) {
					dashing = false;
					
					xscale = 1.5;
					yscale = 0.5;
					
					test = 0;
					
					create_dash_particles(1,3,0.5);
					
					var s = play_sound(snd_down);
					sound_set_gain(s, 0, 50);
					
					if (vsp > 8.5) {
						down = true;
						hsp = sign(hsp);
						alarm_set(1, down_timer);
						
						global.statistics_falls[rm_index] ++;
						
						sound_set_gain(s, 1, 0);
						
						xscale = 1.7;
						yscale = 0.3;
						
						shake_camera(vsp/2);
						rumble(0.8);
						
						
						if (progress_previous > 3) {
							with (instance_create_layer(x, y, "Game", obj_progress_indicator)) {
								var diff = abs(other.progress_previous - get_progress());
								value = diff;
								global.statistics_max_fall[other.rm_index] = max(global.statistics_max_fall[other.rm_index], diff);
							}
						}
						shake_camera(random_range(2,3));
					} else {
						shake_camera(1);
					}
				}
				
		    } else if vsp_final < 0 { 
				// Top
				
		    }
		
			// Stope moving vertically
			vsp = 0;
			vsp_final = 0;
		}
	}
	if (movement_pause == 0) {
		y += vsp_final;
	}
}

function process_animation() {
	image_speed = 1;
	image_xscale = dir;
	
	if (down) {
		sprite_index = spr_player_down;
	} else {
		if (place_meeting(x, y+1, obj_wall)) {
			if (xaxis != 0) {
				sprite_index = spr_player_walk;
			} else {
				sprite_index = spr_player_idle;
			}
		} else {
			if (vsp > 0) {
				sprite_index = spr_player_fall;
			} else {
				sprite_index = spr_player_jump;
			}
		}
	}
}

function create_dash_particles(min_=3, max_=6, size=1) {
	repeat(irandom_range(min_, max_)) {
		var p = instance_create_depth(x, y, depth+10, obj_cloud_particle);
		
		if (size != 1) {
			with (p) {
				for (var i = 0; i < array_length(blobs); i ++) {
					blobs[i].radius *= size;
				}
			}
		}
	}
	
	
}

function get_sprite_blue() {
	var b_spr = -1;
	switch (sprite_index) {
		case spr_player_idle: b_spr = spr_player_idle_blue; break;
		case spr_player_walk: b_spr = spr_player_walk_blue; break;
		case spr_player_jump: b_spr = spr_player_jump_blue; break;
		case spr_player_fall: b_spr = spr_player_fall_blue; break;
		case spr_player_down: b_spr = spr_player_down_blue; break;
	}
	return b_spr;
}