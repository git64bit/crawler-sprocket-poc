/*
    Segment and coupon extraction.
*/

module angular_wedge_2d(radius, angle, steps = 72) {
    polygon(
        points = concat(
            [[0, 0]],
            [
                for (i = [0 : steps])
                    let(a = -angle / 2 + i * angle / steps)
                    [radius * cos(a), radius * sin(a)]
            ]
        )
    );
}

module angular_mask(c, center_angle, included_angle) {
    rotate(center_angle)
        translate([0, 0, -1])
            linear_extrude(height = face_width(c) + 2)
                angular_wedge_2d(
                    tip_radius(c) + max(10, pitch(c)),
                    included_angle
                );
}

module sprocket_segment(c, index = 0, shell = true) {
    n = segment_count(c);
    assert(index >= 0 && index < n,
        str("Segment index must be from 0 through ", n - 1, "."));

    // When teeth divide evenly into segments, boundaries fall through pockets.
    center_angle = index * segment_angle(c) + segment_angle(c) / 2;

    if (n == 1) {
        if (shell)
            printed_shell(c);
        else
            sprocket_solid(c);
    } else {
        intersection() {
            if (shell)
                printed_shell(c);
            else
                sprocket_solid(c);

            angular_mask(c, center_angle, segment_angle(c));
        }
    }
}

module two_tooth_coupon(c, shell = true) {
    coupon_angle = 2.5 * tooth_angle(c);

    intersection() {
        if (shell)
            printed_shell(c);
        else
            sprocket_solid(c);

        // Center the coupon on a tooth rather than a pocket.
        angular_mask(c, tooth_angle(c) / 2, coupon_angle);
    }
}
