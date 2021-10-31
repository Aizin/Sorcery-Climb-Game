
ps = part_system_create();
part_system_depth(ps, depth);

p = part_type_create();

part_type_color1(p, c_white);
part_type_size(p, 1, 2, 0, 0);
part_type_speed(p, 0.5, 1, 0, 0);
part_type_direction(p, 260, 280, 0, 5);
part_type_life(p, 300, 400);

strength = 1;