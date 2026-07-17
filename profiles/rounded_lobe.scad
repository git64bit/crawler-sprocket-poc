/*
    Thick rounded-lobe tooth profile.

    The sprocket body and each tooth are constructed independently, then
    circular bushing pockets are subtracted. This prevents the flat block
    shape created when pockets are cut from one full outside-diameter disk.
*/

module rounded_lobe_tooth_2d(c) {
    round_r = tooth_round_radius(c);
    root_r = tooth_body_radius(c);
    tip_center_r = max(root_r + round_r, tip_radius(c) - round_r);
    root_half = tooth_root_half_angle(c);
    tip_half = tooth_tip_half_angle(c);

    hull() {
        for (a = [-root_half, root_half])
            translate([root_r * cos(a), root_r * sin(a)])
                circle(r = round_r, $fn = 32);

        for (a = [-tip_half, tip_half])
            translate([tip_center_r * cos(a), tip_center_r * sin(a)])
                circle(r = round_r, $fn = 32);
    }
}

module rounded_lobe_profile_2d(c) {
    difference() {
        union() {
            circle(r = tooth_body_radius(c), $fn = body_fn(c));

            for (i = [0 : teeth(c) - 1])
                rotate((i + 0.5) * tooth_angle(c))
                    rounded_lobe_tooth_2d(c);
        }

        circle(r = inner_radius(c), $fn = 180);

        for (i = [0 : teeth(c) - 1])
            rotate(i * tooth_angle(c))
                translate([seat_center_radius(c), 0])
                    circle(r = pocket_radius(c), $fn = 72);
    }
}
