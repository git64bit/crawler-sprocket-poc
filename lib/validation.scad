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

    if (segment_chord(c) > bed_usable(c))
        echo("WARNING: segment outer chord exceeds configured usable bed width.");

    if (teeth(c) % n != 0)
        echo("NOTICE: segment boundaries will not repeat at identical tooth positions.");

    if (teeth(c) % 2 == 0)
        echo("NOTICE: this variant uses an even tooth count.");

    children();
}
