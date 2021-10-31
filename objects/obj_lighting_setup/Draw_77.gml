/// @desc

shader_set(shd_bloom);
	shader_set_uniform_f(u_bloom_intensity, bloom_intensity);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	draw_surface_ext(application_surface,0,0,4,4,0,c_white,1);
	gpu_set_blendmode(bm_normal);
shader_reset();