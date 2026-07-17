/*
    Crawler Sprocket POC
    Batch 002

    Open this file in OpenSCAD, select a variant and output mode, press F6,
    then export the result as STL.
*/

include <lib/indices.scad>
include <config/profiles.scad>
include <config/variants.scad>
include <lib/sprocket_math.scad>
include <lib/validation.scad>
include <profiles/rounded_lobe.scad>
include <profiles/circular_pocket.scad>
include <parts/sprocket.scad>
include <parts/segmentation.scad>
include <parts/preview.scad>

// ---------- USER CONTROLS ----------

variant_name_selected = "POC_24IN_19T";

// full_solid, full_shell, segment, coupon, core,
// assembly_preview, shell_core_preview
output_mode = "segment";

// Used only when output_mode == "segment".
segment_index = 0;

// Shows the nominal bushings for visual fit checking.
// Keep false when exporting an STL.
show_bushings = false;

// Preview resolution. Reduce $fs for smoother final exports.
$fa = 4;
$fs = 1.0;

// ---------- BUILD ----------

c = variant_by_name(variant_name_selected);

validate_variant(c) {
    if (output_mode == "full_solid") {
        sprocket_solid(c);
    } else if (output_mode == "full_shell") {
        printed_shell(c);
    } else if (output_mode == "segment") {
        sprocket_segment(c, index = segment_index, shell = true);
    } else if (output_mode == "coupon") {
        two_tooth_coupon(c, shell = true);
    } else if (output_mode == "core") {
        concrete_core(c);
    } else if (output_mode == "assembly_preview") {
        assembly_preview(c);
    } else if (output_mode == "shell_core_preview") {
        shell_and_core_preview(c);
    } else {
        assert(false, str("Unknown output_mode: ", output_mode));
    }

    if (show_bushings && output_mode != "core")
        preview_bushings(c);
}
