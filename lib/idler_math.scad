/*
    Idler carrier, liner, mold, and reference-hardware calculations.
*/

function architecture_name(c) = c[V_ARCHITECTURE];
function has_idler_architecture(c) = architecture_name(c) != "NONE";
function selected_architecture(c) =
    idler_architecture_by_name(architecture_name(c));

function mold_wall(c) = selected_architecture(c)[A_MOLD_WALL];
function mold_floor(c) = selected_architecture(c)[A_MOLD_FLOOR];
function mold_release(c) = selected_architecture(c)[A_MOLD_RELEASE];

function liner_thickness(c) = selected_architecture(c)[A_LINER_T];
function liner_fit_clearance(c) = selected_architecture(c)[A_LINER_FIT_CLR];
function liner_axial_clearance(c) = selected_architecture(c)[A_LINER_AXIAL_CLR];
function liner_tail_depth(c) = selected_architecture(c)[A_LINER_TAIL_DEPTH];
function liner_tail_width(c) = selected_architecture(c)[A_LINER_TAIL_WIDTH];
function liner_height(c) = face_width(c) - 2 * liner_axial_clearance(c);
function liner_tail_outer_radius(c) = root_radius(c) - liner_thickness(c) / 2;
function liner_tail_inner_radius(c) =
    liner_tail_outer_radius(c) - liner_tail_depth(c);

function side_plate_thickness(c) = selected_architecture(c)[A_PLATE_T];
function side_plate_edge_clearance(c) =
    selected_architecture(c)[A_PLATE_EDGE_CLR];
function side_plate_center_hole(c) =
    selected_architecture(c)[A_PLATE_CENTER_D];
function side_plate_radius(c) = root_radius(c) - side_plate_edge_clearance(c);

function module_rod_d(c) = selected_architecture(c)[A_MODULE_ROD_D];
function module_rod_clearance(c) =
    selected_architecture(c)[A_MODULE_ROD_CLR];
function module_rod_hole_d(c) =
    module_rod_d(c) + 2 * module_rod_clearance(c);
function module_rod_position_ratio(c) =
    selected_architecture(c)[A_MODULE_ROD_POS_R];
function module_rod_radius(c) =
    inner_radius(c)
    + module_rod_position_ratio(c)
    * (side_plate_radius(c) - inner_radius(c));

function registration_depth(c) =
    selected_architecture(c)[A_REGISTRATION_DEPTH];
function registration_clearance(c) =
    selected_architecture(c)[A_REGISTRATION_CLR];
function registration_outer_radius(c) =
    inner_radius(c) - registration_clearance(c);
function registration_inner_radius(c) =
    registration_outer_radius(c) - registration_depth(c);

function hub_bolt_count(c) = selected_architecture(c)[A_HUB_BOLT_COUNT];
function hub_bolt_circle_d(c) = selected_architecture(c)[A_HUB_BCD];
function hub_bolt_circle_radius(c) = hub_bolt_circle_d(c) / 2;
function hub_bolt_hole_d(c) = selected_architecture(c)[A_HUB_HOLE_D];
function hub_flange_d(c) = selected_architecture(c)[A_HUB_FLANGE_D];
function hub_flange_radius(c) = hub_flange_d(c) / 2;
function shaft_d(c) = selected_architecture(c)[A_SHAFT_D];

function fiberglass_rod_d(c) = selected_architecture(c)[A_FIBERGLASS_D];
function fiberglass_chord_inset(c) =
    selected_architecture(c)[A_FIBERGLASS_INSET];
function fiberglass_chord_radius(c) =
    root_radius(c) - fiberglass_chord_inset(c);
function fiberglass_chord_half_angle(c) = tooth_angle(c) * 0.30;

function total_idler_width(c) =
    face_width(c) + 2 * side_plate_thickness(c);
