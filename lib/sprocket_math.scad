/*
    Shared parameter accessors and geometry calculations.
    OpenSCAD trigonometric functions use degrees.
*/

function variant_name(c)        = c[V_NAME];
function pitch(c)               = c[V_PITCH];
function bushing_d(c)           = c[V_BUSHING_D];
function teeth(c)               = c[V_TEETH];
function link_gap(c)            = c[V_LINK_GAP];
function side_clearance(c)      = c[V_SIDE_CLR];
function inner_d(c)             = c[V_INNER_D];
function inner_radius(c)        = inner_d(c) / 2;
function shell_wall(c)          = c[V_SHELL_WALL];
function skin(c)                = c[V_SKIN];
function configured_segments(c) = c[V_SEGMENTS];
function bed_usable(c)          = c[V_BED_USABLE];
function profile_name(c)        = c[V_PROFILE];
function fill_port_d(c)         = c[V_FILL_PORT_D];
function vent_port_d(c)         = c[V_VENT_PORT_D];
function idler_architecture_name(c) = c[V_ARCHITECTURE];

function selected_profile(c)     = profile_by_name(profile_name(c));
function profile_generator(c)    = selected_profile(c)[P_GENERATOR];
function radial_clearance(c)     = selected_profile(c)[P_RADIAL_CLR_R] * pitch(c);
function tip_height(c)           = selected_profile(c)[P_TIP_HEIGHT_R] * pitch(c);
function seat_shift(c)           = selected_profile(c)[P_SEAT_SHIFT_R] * pitch(c);
function body_over_root(c)       = selected_profile(c)[P_BODY_OVER_ROOT_R] * pitch(c);
function root_half_angle_ratio(c)= selected_profile(c)[P_ROOT_HALF_ANGLE_R];
function tip_half_angle_ratio(c) = selected_profile(c)[P_TIP_HALF_ANGLE_R];
function tooth_round_radius(c)   = selected_profile(c)[P_TOOTH_ROUND_R] * pitch(c);
function valley_mouth_ratio(c)   = selected_profile(c)[P_VALLEY_MOUTH_R];

function tooth_angle(c) = 360 / teeth(c);

function pitch_radius(c) =
    pitch(c) / (2 * sin(180 / teeth(c)));

function pitch_diameter(c) = 2 * pitch_radius(c);

function pocket_radius(c) =
    bushing_d(c) / 2 + radial_clearance(c);

function seat_center_radius(c) =
    pitch_radius(c) + seat_shift(c);

function root_radius(c) =
    seat_center_radius(c) - pocket_radius(c);

function tip_radius(c) =
    pitch_radius(c) + tip_height(c);

function outside_diameter(c) = 2 * tip_radius(c);

function tooth_body_radius(c) =
    root_radius(c) + body_over_root(c);

function tooth_root_half_angle(c) =
    tooth_angle(c) * root_half_angle_ratio(c);

function tooth_tip_half_angle(c) =
    tooth_angle(c) * tip_half_angle_ratio(c);

function valley_throat_width(c) =
    2 * pocket_radius(c);

function valley_exit_radius(c) =
    valley_mouth_ratio(c) * pitch(c) / 2;

function valley_exit_width(c) =
    2 * valley_exit_radius(c);

// The exit-circle center is far enough outside that the nominal bushing can
// leave the sprocket completely while remaining inside the cutout.
function valley_exit_center_radius(c) =
    tip_radius(c) + bushing_d(c) / 2 + radial_clearance(c);

function valley_hull_dx(c) =
    valley_exit_center_radius(c) - seat_center_radius(c);

function valley_hull_dr(c) =
    valley_exit_radius(c) - pocket_radius(c);

// Upper external tangent of the two circles used by hull().
function valley_flank_slope(c) =
    valley_hull_dr(c)
    / sqrt(
        valley_hull_dx(c) * valley_hull_dx(c)
        - valley_hull_dr(c) * valley_hull_dr(c)
    );

function valley_flank_intercept(c) =
    let(m = valley_flank_slope(c))
    pocket_radius(c) * sqrt(m * m + 1)
    - m * seat_center_radius(c);

function valley_tip_intersection_x(c) =
    let(
        m = valley_flank_slope(c),
        b = valley_flank_intercept(c),
        qa = 1 + m * m,
        qb = 2 * m * b,
        qc = b * b - tip_radius(c) * tip_radius(c)
    )
    (-qb + sqrt(qb * qb - 4 * qa * qc)) / (2 * qa);

function valley_tip_opening(c) =
    let(
        m = valley_flank_slope(c),
        b = valley_flank_intercept(c),
        x = valley_tip_intersection_x(c)
    )
    2 * (m * x + b);

function tip_pitch_chord(c) =
    2 * tip_radius(c) * sin(180 / teeth(c));

function tip_tooth_width(c) =
    tip_pitch_chord(c) - valley_tip_opening(c);

function root_tooth_width(c) =
    pitch(c) - valley_throat_width(c);

function bushing_path_clearance(c) =
    valley_throat_width(c) - bushing_d(c);

function face_width(c) =
    link_gap(c) - 2 * side_clearance(c);

function core_height(c) =
    face_width(c) - skin(c);

function auto_segment_count(c) =
    bed_usable(c) >= outside_diameter(c)
        ? 1
        : ceil(180 / asin(min(1, bed_usable(c) / outside_diameter(c))));

function segment_count(c) =
    configured_segments(c) > 0
        ? configured_segments(c)
        : auto_segment_count(c);

function segment_angle(c) = 360 / segment_count(c);

function segment_chord(c, n = segment_count(c)) =
    n == 1
        ? outside_diameter(c)
        : 2 * tip_radius(c) * sin(180 / n);

function body_fn(c) = max(180, teeth(c) * 24);
