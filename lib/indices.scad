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
