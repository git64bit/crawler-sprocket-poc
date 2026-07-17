/*
    Geometry checks and console summary.
*/

module validate_variant(c) {
    n = segment_count(c);
    radial_web = root_radius(c) - inner_radius(c);

    assert(pitch(c) > 0, "Pitch must be positive.");
    assert(bushing_d(c) > 0, "Bushing diameter must be positive.");
    assert(teeth(c) >= 5, "Tooth count must be at least 5 for this POC generator.");
    assert(face_width(c) > skin(c),
        "Bottom skin leaves no internal casting depth.");
    assert(radial_web > 2 * shell_wall(c),
        "Inner opening leaves no useful radial casting cavity.");
    assert(n >= 1, "Segment count must be at least 1.");
    if (has_idler_architecture(c)) {
        assert(liner_height(c) > 0,
            "Wear-liner axial clearances consume the full face width.");
        assert(side_plate_radius(c) > inner_radius(c),
            "Side plate does not overlap the cast modules.");
        assert(module_rod_radius(c) > inner_radius(c)
            && module_rod_radius(c) < side_plate_radius(c),
            "Module rod must lie inside the side-plate/module overlap.");
        assert(registration_inner_radius(c) > hub_flange_radius(c),
            "Registration ring conflicts with the reference hub flange.");
        assert(liner_tail_inner_radius(c) < side_plate_radius(c)
            && liner_tail_outer_radius(c) > side_plate_radius(c),
            "Side plate must overlap the liner retention tail.");
    }

    if (profile_generator(c) == "rounded_lobe") {
        assert(tooth_round_radius(c) > 0,
            "Rounded-lobe profile requires positive tooth rounding.");
        assert(tooth_body_radius(c) < tip_radius(c),
            "Rounded-lobe body radius must be below the tooth tip.");
        assert(root_half_angle_ratio(c) > tip_half_angle_ratio(c),
            "Rounded-lobe tooth must taper from root to tip.");
        assert(root_half_angle_ratio(c) < 0.5,
            "Rounded-lobe root half-angle ratio must be below 0.5.");
        assert(tip_half_angle_ratio(c) > 0,
            "Rounded-lobe tip half-angle ratio must be positive.");
    }

    if (profile_generator(c) == "open_valley") {
        assert(valley_exit_width(c) > valley_throat_width(c),
            "Open-valley mouth must be wider than its bushing throat.");
        assert(valley_tip_opening(c) < tip_pitch_chord(c),
            "Open-valley mouth consumes the entire tooth pitch.");
        assert(tip_tooth_width(c) > 2 * shell_wall(c),
            "Open-valley tooth tip is too narrow for the printed shell.");
        assert(root_tooth_width(c) > 2 * shell_wall(c),
            "Open-valley tooth root is too narrow for the printed shell.");
        assert(valley_hull_dx(c) > valley_hull_dr(c),
            "Open-valley hull circles overlap too aggressively for a tangent flank.");
    }

    echo("----- CRAWLER SPROCKET POC -----");
    echo("Variant", variant_name(c));
    echo("Profile", profile_name(c));
    echo("Pitch diameter (mm)", pitch_diameter(c));
    echo("Outside diameter (mm)", outside_diameter(c));
    echo("Root diameter (mm)", 2 * root_radius(c));
    echo("Face width (mm)", face_width(c));
    echo("Concrete depth (mm)", core_height(c));
    echo("Shell top", "OPEN");
    echo("Segments", n);
    echo("Outer chord per segment (mm)", segment_chord(c));
    echo("Idler architecture", architecture_name(c));

    if (has_idler_architecture(c)) {
        echo("Side-plate outside diameter (mm)", 2 * side_plate_radius(c));
        echo("Module threaded-rod radius (mm)", module_rod_radius(c));
        echo("Liner thickness (mm)", liner_thickness(c));
        echo("Liner retention-tail radial range (mm)",
            [liner_tail_inner_radius(c), liner_tail_outer_radius(c)]);
        echo("Registration-ring diameters (mm)",
            [2 * registration_inner_radius(c), 2 * registration_outer_radius(c)]);
        echo("Reference shaft diameter (mm)", shaft_d(c));
    }

    if (profile_generator(c) == "open_valley") {
        echo("Bushing diameter (mm)", bushing_d(c));
        echo("Valley throat width (mm)", valley_throat_width(c));
        echo("Valley exit-circle width (mm)", valley_exit_width(c));
        echo("Valley opening at tooth tips (mm)", valley_tip_opening(c));
        echo("Minimum bushing path clearance (mm)", bushing_path_clearance(c));
        echo("Approximate tooth root width (mm)", root_tooth_width(c));
        echo("Approximate tooth tip width (mm)", tip_tooth_width(c));
    }

    if (segment_chord(c) > bed_usable(c))
        echo("WARNING: segment outer chord exceeds configured usable bed width.");

    if (teeth(c) % n != 0)
        echo("NOTICE: segment boundaries will not repeat at identical tooth positions.");

    if (teeth(c) % 2 == 0)
        echo("NOTICE: this variant uses an even tooth count.");

    children();
}
