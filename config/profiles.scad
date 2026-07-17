/*
    Proof-of-concept profile presets.

    Ratios are normalized to track pitch so the same profile family can be
    used at several physical sizes. These are geometry experiments, not
    production crawler-tooth specifications.
*/

profiles = [
    // name, generator, radial clearance/pitch, tip height/pitch,
    // seat shift/pitch, body over root/pitch, root half-angle ratio,
    // tip half-angle ratio, tooth rounding/pitch, valley exit-circle width/pitch

    ["POCKET_SHALLOW", "circular_pocket",
        0.010, 0.12, 0.000, 0, 0, 0, 0, 0],

    ["POCKET_STANDARD", "circular_pocket",
        0.015, 0.18, 0.000, 0, 0, 0, 0, 0],

    ["POCKET_DEEP", "circular_pocket",
        0.020, 0.22, 0.015, 0, 0, 0, 0, 0],

    // Batch 002 reference profile. Retained only for comparison.
    ["ROUNDED_THICK", "rounded_lobe",
        0.015, 0.18, 0.000, 0.140, 0.42, 0.20, 0.035, 0],

    // Batch 003 profiles. The valley is open across the full bushing
    // diameter at the seat center and widens toward the outside.
    ["OPEN_VALLEY_STOUT", "open_valley",
        0.015, 0.18, 0.000, 0, 0, 0, 0, 0.80],

    ["OPEN_VALLEY_STANDARD", "open_valley",
        0.015, 0.18, 0.000, 0, 0, 0, 0, 0.90],

    ["OPEN_VALLEY_WIDE", "open_valley",
        0.015, 0.18, 0.000, 0, 0, 0, 0, 1.00]
];

function profile_by_name(name) =
    let(matches = [for (p = profiles) if (p[P_NAME] == name) p])
    assert(
        len(matches) == 1,
        str("Expected exactly one profile named '", name, "'.")
    )
    matches[0];
