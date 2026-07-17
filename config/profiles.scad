/*
    Proof-of-concept profile presets.

    Ratios are normalized to track pitch so the same profile family can be
    used at several physical sizes. These are geometry experiments, not
    production crawler-tooth specifications.
*/

profiles = [
    // name,             generator,          radial clearance/pitch,
    //                                      tip height/pitch, seat shift/pitch
    ["POCKET_SHALLOW",  "circular_pocket",  0.010, 0.12, 0.000],
    ["POCKET_STANDARD", "circular_pocket",  0.015, 0.18, 0.000],
    ["POCKET_DEEP",     "circular_pocket",  0.020, 0.22, 0.015]
];

function profile_by_name(name) =
    let(matches = [for (p = profiles) if (p[P_NAME] == name) p])
    assert(
        len(matches) == 1,
        str("Expected exactly one profile named '", name, "'.")
    )
    matches[0];
