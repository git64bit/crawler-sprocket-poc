/*
    Proof-of-concept idler assembly presets.

    These values describe manufacturing and attachment geometry. They are
    intentionally separate from the track profile so the same accepted tooth
    geometry can be mounted in different carrier arrangements.
*/

idler_architectures = [
    // name,
    // TPU mold wall, TPU mold floor, mold release allowance,
    // wear-liner thickness, liner fit clearance, liner axial clearance,
    // liner retention-tail depth, liner retention-tail width,
    // side-plate thickness, side-plate edge clearance, side-plate center hole,
    // module rod diameter, module rod radial clearance,
    // module rod position across the plate/module overlap,
    // registration-ring depth, registration-ring radial clearance,
    // hub bolt count, hub bolt-circle diameter, hub bolt-hole diameter,
    // reference hub-flange diameter, reference shaft diameter,
    // fiberglass rod diameter, fiberglass chord inset

    ["IDLER_POC_A",
        2.4, 2.4, 0.15,
        4.0, 0.60, 0.60,
        18.0, 18.0,
        8.0, 10.0, 120.0,
        8.0, 1.00,
        0.55,
        30.0, 0.50,
        8, 160.0, 10.0,
        200.0, 30.0,
        6.0, 15.0]
];

function idler_architecture_by_name(name) =
    let(matches = [for (a = idler_architectures) if (a[A_NAME] == name) a])
    assert(
        len(matches) == 1,
        str("Expected exactly one idler architecture named '", name, "'.")
    )
    matches[0];
