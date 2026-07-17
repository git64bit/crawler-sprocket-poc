/*
    Initial proof-of-concept tooth profile.

    Circular pockets are subtracted at the pitch locations. This reproduces
    the design logic of the first uploaded model and provides a stable base
    for later generated engagement profiles.
*/

module circular_pocket_profile_2d(c) {
    difference() {
        circle(r = tip_radius(c), $fn = body_fn(c));
        circle(r = inner_radius(c), $fn = 180);

        for (i = [0 : teeth(c) - 1]) {
            rotate(i * tooth_angle(c))
                translate([seat_center_radius(c), 0])
                    circle(r = pocket_radius(c), $fn = 72);
        }
    }
}

module sprocket_profile_2d(c) {
    generator = profile_generator(c);

    if (generator == "circular_pocket") {
        circular_pocket_profile_2d(c);
    } else {
        assert(false, str("Unsupported profile generator: ", generator));
    }
}
