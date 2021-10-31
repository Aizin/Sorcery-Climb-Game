/// @desc



application_surface_draw_enable(false);

u_bloom_intensity = shader_get_uniform(shd_bloom, "intensity");
bloom_intensity_max = 0.4;
bloom_intensity = bloom_intensity_max;

u_pos = shader_get_uniform(shd_light,"u_pos");
u_zz = shader_get_uniform(shd_light,"zz");
u_str = shader_get_uniform(shd_light,"u_str");
u_dir = shader_get_uniform(shd_light,"u_dir");
u_fov = shader_get_uniform(shd_light,"u_fov");
u_pos2 = shader_get_uniform(shd_shadow,"u_pos");
u_nmap = shader_get_sampler_index(shd_light,"u_nmap");

vertex_format_begin();
vertex_format_add_position_3d();
vf = vertex_format_end();
vb = vertex_create_buffer();


shad_surf = noone;

function bg_begin() {
	gpu_set_colorwriteenable(1,1,1,0);
}
function bg_end() {
	gpu_set_colorwriteenable(1,1,1,1);
}

var bg_layer = layer_get_id("Background");
layer_script_begin(bg_layer,bg_begin);
layer_script_end(bg_layer,bg_end);
