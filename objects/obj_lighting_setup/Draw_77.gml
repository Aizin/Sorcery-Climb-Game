/// @desc

var scale = 1;

if (global.fullscreen) {
	scale = window_get_height() / CH;
} else {
	scale = view_get_hport(CAM) / CH;
}

shader_set(shd_bloom);
	shader_set_uniform_f(u_bloom_intensity, bloom_intensity);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	draw_surface_ext(application_surface,0,0,scale,scale,0,c_white,1);
	gpu_set_blendmode(bm_normal);
shader_reset();

