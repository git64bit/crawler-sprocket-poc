/*
    Batch 004 idler architecture.

    The accepted open-valley track interface remains unchanged. This file adds:

    - separate cast tooth modules;
    - one replaceable valley liner per valley;
    - a removable open-top TPU casting mold;
    - two rigid side plates;
    - an inner registration ring;
    - module-clamping threaded-rod holes;
    - external hub and shaft reference geometry; and
    - fiberglass reinforcement placement previews.

    The metal hub and shaft are reference geometry only. Bearings remain outside
    the idler body and are not press-fit into printed or cast material.
*/

module liner_working_band_2d(c) {
    intersection() {
        difference() {
            offset(delta = liner_thickness(c))
                open_valley_cutout_2d(c);
            open_valley_cutout_2d(c);
        }

        circle(r = tip_radius(c), $fn = body_fn(c));
    }
}

module liner_retention_tail_2d(c) {
    r_inner = liner_tail_inner_radius(c);
    r_outer = liner_tail_outer_radius(c);
    half_w = liner_tail_width(c) / 2;

    polygon([
        [r_inner, -half_w],
        [r_outer, -half_w],
        [r_outer,  half_w],
        [r_inner,  half_w]
    ]);
}

module wear_liner_2d(c) {
    union() {
        liner_working_band_2d(c);
        liner_retention_tail_2d(c);
    }
}

module wear_liner_slot_2d(c) {
    offset(delta = liner_fit_clearance(c))
        wear_liner_2d(c);
}

module one_wear_liner(c, index = 0) {
    assert(profile_generator(c) == "open_valley",
        "Batch 004 wear liners require the open-valley profile.");
    assert(index >= 0 && index < teeth(c),
        str("Liner index must be from 0 through ", teeth(c) - 1, "."));

    rotate(index * tooth_angle(c))
        translate([0, 0, liner_axial_clearance(c)])
            linear_extrude(height = liner_height(c), convexity = 12)
                wear_liner_2d(c);
}

module all_wear_liners(c) {
    for (i = [0 : teeth(c) - 1])
        one_wear_liner(c, index = i);
}

module module_clamp_holes_2d(c) {
    for (i = [0 : teeth(c) - 1])
        rotate((i + 0.5) * tooth_angle(c))
            translate([module_rod_radius(c), 0])
                circle(d = module_rod_hole_d(c), $fn = 48);
}

module idler_cast_ring_without_rod_holes_2d(c) {
    difference() {
        sprocket_profile_2d(c);

        for (i = [0 : teeth(c) - 1])
            rotate(i * tooth_angle(c))
                wear_liner_slot_2d(c);
    }
}

module idler_cast_ring_2d(c) {
    difference() {
        idler_cast_ring_without_rod_holes_2d(c);
        module_clamp_holes_2d(c);
    }
}

module raw_tooth_module_outline_2d(c, index = 0) {
    center_angle = index * segment_angle(c) + segment_angle(c) / 2;

    intersection() {
        sprocket_profile_2d(c);
        rotate(center_angle)
            angular_wedge_2d(
                tip_radius(c) + max(10, pitch(c)),
                segment_angle(c)
            );
    }
}

module cast_tooth_module_2d(c, index = 0) {
    center_angle = index * segment_angle(c) + segment_angle(c) / 2;

    intersection() {
        idler_cast_ring_2d(c);
        rotate(center_angle)
            angular_wedge_2d(
                tip_radius(c) + max(10, pitch(c)),
                segment_angle(c)
            );
    }
}

module cast_tooth_module_mold_cavity_2d(c, index = 0) {
    center_angle = index * segment_angle(c) + segment_angle(c) / 2;

    intersection() {
        idler_cast_ring_without_rod_holes_2d(c);
        rotate(center_angle)
            angular_wedge_2d(
                tip_radius(c) + max(10, pitch(c)),
                segment_angle(c)
            );
    }
}

module cast_tooth_module(c, index = 0) {
    assert(index >= 0 && index < segment_count(c),
        str("Module index must be from 0 through ", segment_count(c) - 1, "."));

    linear_extrude(height = face_width(c), convexity = 12)
        cast_tooth_module_2d(c, index = index);
}

module all_cast_tooth_modules(c) {
    for (i = [0 : segment_count(c) - 1])
        cast_tooth_module(c, index = i);
}

module tpu_casting_mold(c, index = 0) {
    assert(index >= 0 && index < segment_count(c),
        str("Mold index must be from 0 through ", segment_count(c) - 1, "."));

    difference() {
        linear_extrude(height = face_width(c) + mold_floor(c), convexity = 12)
            offset(delta = mold_wall(c))
                raw_tooth_module_outline_2d(c, index = index);

        translate([0, 0, mold_floor(c)])
            linear_extrude(height = face_width(c) + 0.2, convexity = 12)
                offset(delta = mold_release(c))
                    cast_tooth_module_mold_cavity_2d(c, index = index);

        // Shallow socket for a separate smooth core pin. The pin, rather than
        // a tall TPU pillar, forms the final threaded-rod clearance hole.
        rotate((index + 0.5) * tooth_angle(c))
            translate([
                module_rod_radius(c),
                0,
                mold_floor(c) / 2
            ])
                cylinder(
                    h = mold_floor(c) / 2 + 0.2,
                    d = module_rod_hole_d(c),
                    $fn = 48
                );
    }
}

module rod_core_reference(c) {
    cylinder(
        h = face_width(c) + 8,
        d = module_rod_hole_d(c),
        $fn = 48
    );
}

module side_plate_2d(c) {
    difference() {
        circle(r = side_plate_radius(c), $fn = body_fn(c));
        circle(d = side_plate_center_hole(c), $fn = 120);
        module_clamp_holes_2d(c);

        for (i = [0 : hub_bolt_count(c) - 1])
            rotate(i * 360 / hub_bolt_count(c))
                translate([hub_bolt_circle_radius(c), 0])
                    circle(d = hub_bolt_hole_d(c), $fn = 48);
    }
}

module side_plate(c) {
    linear_extrude(height = side_plate_thickness(c), convexity = 8)
        side_plate_2d(c);
}

module registration_ring(c) {
    difference() {
        cylinder(
            h = face_width(c),
            r = registration_outer_radius(c),
            $fn = body_fn(c)
        );
        translate([0, 0, -0.1])
            cylinder(
                h = face_width(c) + 0.2,
                r = registration_inner_radius(c),
                $fn = body_fn(c)
            );
    }
}

module hub_flange_reference(c, thickness = 12) {
    difference() {
        cylinder(h = thickness, d = hub_flange_d(c), $fn = 120);
        translate([0, 0, -0.1])
            cylinder(h = thickness + 0.2, d = shaft_d(c), $fn = 72);

        for (i = [0 : hub_bolt_count(c) - 1])
            rotate(i * 360 / hub_bolt_count(c))
                translate([hub_bolt_circle_radius(c), 0, -0.1])
                    cylinder(
                        h = thickness + 0.2,
                        d = hub_bolt_hole_d(c),
                        $fn = 48
                    );
    }
}

module module_rods_reference(c) {
    total_h = total_idler_width(c) + 16;

    for (i = [0 : teeth(c) - 1])
        rotate((i + 0.5) * tooth_angle(c))
            translate([
                module_rod_radius(c),
                0,
                -side_plate_thickness(c) - 8
            ])
                cylinder(h = total_h, d = module_rod_d(c), $fn = 36);
}

module rod_between_points(p1, p2, d) {
    hull() {
        translate(p1) sphere(d = d, $fn = 24);
        translate(p2) sphere(d = d, $fn = 24);
    }
}

module fiberglass_reinforcement_reference(c, index = 0) {
    a_center = (index + 0.5) * tooth_angle(c);
    a_half = fiberglass_chord_half_angle(c);
    r = fiberglass_chord_radius(c);
    z = face_width(c) / 2;

    p1 = [
        r * cos(a_center - a_half),
        r * sin(a_center - a_half),
        z
    ];
    p2 = [
        r * cos(a_center + a_half),
        r * sin(a_center + a_half),
        z
    ];

    rod_between_points(p1, p2, fiberglass_rod_d(c));
}

module all_fiberglass_reinforcement_reference(c) {
    for (i = [0 : teeth(c) - 1])
        fiberglass_reinforcement_reference(c, index = i);
}

module idler_assembly_preview(c, exploded = false) {
    plate_gap = exploded ? 28 : 0;
    liner_shift = exploded ? face_width(c) + 45 : 0;
    hub_t = 12;

    color([0.56, 0.56, 0.56])
        all_cast_tooth_modules(c);

    color([0.92, 0.46, 0.08])
        if (exploded)
            translate([0, 0, liner_shift]) all_wear_liners(c);
        else
            all_wear_liners(c);

    color([0.20, 0.28, 0.38, 0.55]) {
        translate([0, 0, -side_plate_thickness(c) - plate_gap])
            side_plate(c);
        translate([0, 0, face_width(c) + plate_gap])
            side_plate(c);
    }

    color([0.30, 0.30, 0.32])
        registration_ring(c);

    color([0.18, 0.18, 0.20])
        module_rods_reference(c);

    color([0.82, 0.82, 0.84]) {
        translate([0, 0, -side_plate_thickness(c) - plate_gap - hub_t])
            hub_flange_reference(c, thickness = hub_t);
        translate([0, 0, face_width(c) + side_plate_thickness(c) + plate_gap])
            hub_flange_reference(c, thickness = hub_t);
    }

    color([0.26, 0.26, 0.28])
        translate([
            0,
            0,
            -side_plate_thickness(c) - plate_gap - hub_t - 20
        ])
            cylinder(
                h = total_idler_width(c) + 2 * plate_gap + 2 * hub_t + 40,
                d = shaft_d(c),
                $fn = 72
            );

    color([0.22, 0.50, 0.24])
        all_fiberglass_reinforcement_reference(c);
}
