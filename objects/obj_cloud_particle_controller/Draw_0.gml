/// @desc

if (!instance_exists(obj_cloud_particle) && !instance_exists(obj_particle_slime)) {
	return;
}

if (surface_exists(surf)) {
	
	surface_set_target(surf);
	
		draw_clear_alpha(outline_color, 0);
		
		if (instance_exists(obj_cloud_particle)) {
			with (obj_cloud_particle) {
				draw();
			}
		}
		if (instance_exists(obj_particle_slime)) {
			with (obj_particle_slime) {
				draw();
			}
		}
	surface_reset_target();
	
	var texture_id = surface_get_texture(surf);
	var texelW = texture_get_texel_width(texture_id);
	var texelH = texture_get_texel_height(texture_id);
	
	shader_set(shd_outline);
		shader_set_uniform_f(upixelW, texelW);
		shader_set_uniform_f(upixelH, texelH);
		
		draw_surface(surf, 0, 0);
	shader_reset();
	
} else {
	surf = surface_create(room_width, room_height);
}