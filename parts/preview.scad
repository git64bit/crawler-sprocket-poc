/*
    Non-export preview helpers.
*/

module one_preview_bushing(c, angle = 0, radial_offset = 0, alpha = 0.45) {
    color([0.25, 0.25, 0.25, alpha])
        rotate(angle)
            translate([seat_center_radius(c) + radial_offset, 0, -0.5])
                cylinder(
                    h = face_width(c) + 1,
                    d = bushing_d(c),
                    $fn = 48
                );
}

module preview_bushings(c) {
    for (i = [0 : teeth(c) - 1])
        one_preview_bushing(c, angle = i * tooth_angle(c));
}

module preview_bushing_path(c, pocket_index = 0) {
    travel = tip_radius(c) + bushing_d(c) / 2 - seat_center_radius(c);
    path_offsets = [0, travel * 0.35, travel * 0.70, travel];
    path_alpha = [0.65, 0.45, 0.30, 0.20];

    for (i = [0 : len(path_offsets) - 1])
        one_preview_bushing(
            c,
            angle = pocket_index * tooth_angle(c),
            radial_offset = path_offsets[i],
            alpha = path_alpha[i]
        );
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
