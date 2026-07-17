/*
    Full sprocket, open-top printed shell, and concrete-core volume.

    The complete upper face is open. Concrete can be poured, leveled, added,
    or removed after assembly. The shell retains one bottom skin and the
    profile side walls.
*/

module sprocket_solid(c) {
    linear_extrude(height = face_width(c), convexity = 12)
        sprocket_profile_2d(c);
}

module core_profile_2d(c) {
    offset(delta = -shell_wall(c))
        sprocket_profile_2d(c);
}

module concrete_core(c) {
    translate([0, 0, skin(c)])
        linear_extrude(height = core_height(c), convexity = 12)
            core_profile_2d(c);
}

module casting_cavity(c) {
    translate([0, 0, skin(c)])
        linear_extrude(height = core_height(c) + 0.2, convexity = 12)
            core_profile_2d(c);
}

module printed_shell(c) {
    difference() {
        sprocket_solid(c);
        casting_cavity(c);
    }
}
