/*
    Crawler Idler POC
    Batch 004

    Open this file in OpenSCAD, select a variant and output mode, press F6,
    then export only a part output as STL.
*/

include <lib/indices.scad>
include <config/profiles.scad>
include <config/idler_architectures.scad>
include <config/variants.scad>
include <lib/sprocket_math.scad>
include <lib/idler_math.scad>
include <lib/validation.scad>
include <profiles/open_valley.scad>
include <profiles/rounded_lobe.scad>
include <profiles/circular_pocket.scad>
include <parts/sprocket.scad>
include <parts/segmentation.scad>
include <parts/preview.scad>
include <parts/idler_architecture.scad>

// ---------- USER CONTROLS ----------

variant_name_selected = "POC_24IN_19T";

// Existing profile outputs:
// full_solid, full_shell, segment, coupon, core,
// assembly_preview, shell_core_preview, fit_preview
//
// Batch 004 idler outputs:
// idler_assembly_preview, idler_exploded_preview,
// cast_module, wear_liner, tpu_mold, side_plate,
// registration_ring, hub_reference, rod_core_reference,
// reinforcement_preview
output_mode = "idler_exploded_preview";  //"idler_assembly_preview";

// Used by segment, cast_module, and tpu_mold.
segment_index = 0;

// Used by wear_liner.
liner_index = 0;

// Shows all nominal seated bushings for visual fit checking.
// Keep false when exporting an STL.
show_bushings = false;

// Preview resolution. Reduce $fs for smoother final exports.
$fa = 4;
$fs = 1.0;

// ---------- PROFILE DISPATCH ----------

module sprocket_profile_2d(c) {
    if (profile_generator(c) == "open_valley") {
        open_valley_profile_2d(c);
    } else if (profile_generator(c) == "rounded_lobe") {
        rounded_lobe_profile_2d(c);
    } else if (profile_generator(c) == "circular_pocket") {
        circular_pocket_profile_2d(c);
    } else {
        assert(false, str("Unknown profile generator: ", profile_generator(c)));
    }
}

// ---------- BUILD ----------

c = variant_by_name(variant_name_selected);

idler_output =
    output_mode == "idler_assembly_preview"
    || output_mode == "idler_exploded_preview"
    || output_mode == "cast_module"
    || output_mode == "wear_liner"
    || output_mode == "tpu_mold"
    || output_mode == "side_plate"
    || output_mode == "registration_ring"
    || output_mode == "hub_reference"
    || output_mode == "rod_core_reference"
    || output_mode == "reinforcement_preview";

assert(
    !idler_output || has_idler_architecture(c),
    str("Variant '", variant_name(c), "' has no idler architecture preset.")
)
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
    } else if (output_mode == "fit_preview") {
        color([0.82, 0.62, 0.08])
            two_tooth_coupon(c, shell = true);
        preview_bushing_path(c, pocket_index = 0);
    } else if (output_mode == "idler_assembly_preview") {
        idler_assembly_preview(c, exploded = false);
    } else if (output_mode == "idler_exploded_preview") {
        idler_assembly_preview(c, exploded = true);
    } else if (output_mode == "cast_module") {
        cast_tooth_module(c, index = segment_index);
    } else if (output_mode == "wear_liner") {
        one_wear_liner(c, index = liner_index);
    } else if (output_mode == "tpu_mold") {
        tpu_casting_mold(c, index = segment_index);
    } else if (output_mode == "side_plate") {
        side_plate(c);
    } else if (output_mode == "registration_ring") {
        registration_ring(c);
    } else if (output_mode == "hub_reference") {
        hub_flange_reference(c);
    } else if (output_mode == "rod_core_reference") {
        rod_core_reference(c);
    } else if (output_mode == "reinforcement_preview") {
        cast_tooth_module(c, index = segment_index);
        color([0.22, 0.50, 0.24])
            fiberglass_reinforcement_reference(c, index = segment_index);
    } else {
        assert(false, str("Unknown output_mode: ", output_mode));
    }

    if (show_bushings
        && output_mode != "core"
        && output_mode != "fit_preview"
        && output_mode != "tpu_mold")
        preview_bushings(c);
}
