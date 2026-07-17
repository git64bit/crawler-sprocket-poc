/*
    Full sprocket, printed shell, concrete-core volume, and casting ports.
*/

module sprocket_solid(c) {
    linear_extrude(height = face_width(c), convexity = 12)
        sprocket_profile_2d(c);
}

module concrete_core(c) {
    translate([0, 0, skin(c)])
        linear_extrude(
            height = face_width(c) - 2 * skin(c),
            convexity = 12
        )
            offset(delta = -shell_wall(c))
                sprocket_profile_2d(c);
}

module casting_port_holes(c) {
    n = segment_count(c);
    port_z = face_width(c) - skin(c) - 0.1;
    port_h = skin(c) + 0.2;
    radial_span = root_radius(c) - inner_radius(c);
    fill_r = inner_radius(c) + 0.38 * radial_span;
    vent_r = inner_radius(c) + 0.70 * radial_span;

    for (i = [0 : n - 1]) {
        center_a = i * segment_angle(c) + segment_angle(c) / 2;

        rotate(center_a)
            translate([fill_r, 0, port_z])
                cylinder(h = port_h, d = fill_port_d(c), $fn = 36);

        rotate(center_a + segment_angle(c) * 0.25)
            translate([vent_r, 0, port_z])
                cylinder(h = port_h, d = vent_port_d(c), $fn = 30);
    }
}

module printed_shell(c, with_ports = true) {
    difference() {
        sprocket_solid(c);
        concrete_core(c);

        if (with_ports)
            casting_port_holes(c);
    }
}
