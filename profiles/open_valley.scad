/*
    Open-valley proof-of-concept profile.

    Each bushing valley is a continuous swept cutout made by hulling:

    - a circular seat centered on the pitch circle; and
    - a larger exit circle beyond the tooth tips.

    The seat circle provides the rounded valley floor. The hull removes the
    entire outer half of the enclosure and widens continuously toward the
    outside. A nominal bushing can move radially from its seated position to
    completely outside the sprocket without crossing solid geometry.
*/

module open_valley_cutout_2d(c) {
    hull() {
        translate([seat_center_radius(c), 0])
            circle(r = pocket_radius(c), $fn = 96);

        translate([valley_exit_center_radius(c), 0])
            circle(r = valley_exit_radius(c), $fn = 96);
    }
}

module open_valley_profile_2d(c) {
    difference() {
        circle(r = tip_radius(c), $fn = body_fn(c));
        circle(r = inner_radius(c), $fn = 180);

        for (i = [0 : teeth(c) - 1])
            rotate(i * tooth_angle(c))
                open_valley_cutout_2d(c);
    }
}
