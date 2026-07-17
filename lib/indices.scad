/*
    Array-field indexes.
    OpenSCAD does not provide native records, so named indexes keep the
    configuration tables readable and stable.
*/

// Variant fields
V_NAME          = 0;
V_PITCH         = 1;
V_BUSHING_D     = 2;
V_TEETH         = 3;
V_LINK_GAP      = 4;
V_SIDE_CLR      = 5;
V_INNER_D       = 6;
V_SHELL_WALL    = 7;
V_SKIN          = 8;
V_SEGMENTS      = 9;
V_BED_USABLE    = 10;
V_PROFILE       = 11;
V_FILL_PORT_D   = 12; // Reserved; open-top shells do not use ports.
V_VENT_PORT_D   = 13; // Reserved; open-top shells do not use ports.
V_ARCHITECTURE    = 14;

// Profile fields
P_NAME               = 0;
P_GENERATOR          = 1;
P_RADIAL_CLR_R       = 2;
P_TIP_HEIGHT_R       = 3;
P_SEAT_SHIFT_R       = 4;
P_BODY_OVER_ROOT_R   = 5;
P_ROOT_HALF_ANGLE_R  = 6;
P_TIP_HALF_ANGLE_R   = 7;
P_TOOTH_ROUND_R      = 8;
P_VALLEY_MOUTH_R     = 9;

// Idler architecture fields
A_NAME                 = 0;
A_MOLD_WALL            = 1;
A_MOLD_FLOOR           = 2;
A_MOLD_RELEASE         = 3;
A_LINER_T              = 4;
A_LINER_FIT_CLR        = 5;
A_LINER_AXIAL_CLR      = 6;
A_LINER_TAIL_DEPTH     = 7;
A_LINER_TAIL_WIDTH     = 8;
A_PLATE_T              = 9;
A_PLATE_EDGE_CLR       = 10;
A_PLATE_CENTER_D       = 11;
A_MODULE_ROD_D         = 12;
A_MODULE_ROD_CLR       = 13;
A_MODULE_ROD_POS_R     = 14;
A_REGISTRATION_DEPTH   = 15;
A_REGISTRATION_CLR     = 16;
A_HUB_BOLT_COUNT       = 17;
A_HUB_BCD              = 18;
A_HUB_HOLE_D           = 19;
A_HUB_FLANGE_D         = 20;
A_SHAFT_D              = 21;
A_FIBERGLASS_D         = 22;
A_FIBERGLASS_INSET     = 23;
