/*
    Non-export preview helpers.
*/

module preview_bushings(c) {
    color([0.25, 0.25, 0.25, 0.45])
        for (i = [0 : teeth(c) - 1]) {
            rotate(i * tooth_angle(c))
                translate([seat_center_radius(c), 0, -0.5])
                    cylinder(
                        h = face_width(c) + 1,
                        d = bushing_d(c),
                        $fn = 48
                    );
        }
}

module assembly_preview(c) {
    palette = [
        [0.95, 0.65, 0.10],
        [0.80, 0.45, 0.08]
    ];

    for (i = [0 : segment_count(c) - 1]) {
        color(palette[i % 2])
            sprocket_segment(c, index = i, shell = true);
    }
}

module shell_and_core_preview(c) {
    color([0.95, 0.65, 0.10, 0.55])
        printed_shell(c);

    color([0.55, 0.55, 0.55, 0.80])
        concrete_core(c);
}
