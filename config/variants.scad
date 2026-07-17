/*
    Proof-of-concept sprocket variants.

    Dimensions are millimeters. The examples demonstrate the generator at
    approximately 6-inch, 24-inch, and 48-inch outside diameters. They are
    not tied to a specific commercial track chain.
*/

variants = [
    // name, pitch, bushing OD, teeth, link gap, side clearance,
    // inner diameter, shell wall, bottom skin, segments,
    // usable bed width, profile, reserved fill diameter, reserved vent diameter

    ["POC_06IN_13T",  36, 18, 13,  28, 1.0,  80, 2.4, 2.4,  1, 320,
        "POCKET_SHALLOW", 0, 0],

    // 19 one-tooth segments keep every printed segment identical.
    // Pitch is selected to retain an approximately 24-inch outside diameter.
    ["POC_24IN_19T", 94.7, 48, 19, 78, 1.5, 410, 3.2, 3.2, 19, 320,
        "ROUNDED_THICK", 0, 0],

    ["POC_48IN_25T", 150, 76, 25, 110, 2.0, 860, 4.0, 4.0, 25, 320,
        "POCKET_DEEP", 0, 0]
];

function variant_by_name(name) =
    let(matches = [for (v = variants) if (v[V_NAME] == name) v])
    assert(
        len(matches) == 1,
        str("Expected exactly one variant named '", name, "'.")
    )
    matches[0];
