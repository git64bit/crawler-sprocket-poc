# Batch 001 — Parametric Skeleton

## Delivered

- Repository skeleton.
- Three demonstration variants.
- Three normalized circular-pocket presets.
- Pitch, root, tip, face-width, and segmentation calculations.
- Hollow shell and concrete-core geometry.
- Casting fill and vent holes.
- Full, segment, coupon, core, and preview outputs.
- Geometry checks and console diagnostics.

## Test procedure

### Test 1 — Baseline segment

1. Open `main.scad`.
2. Select `POC_24IN_21T`.
3. Select `segment`.
4. Render with F6.
5. Confirm one curved segment appears with three tooth regions and a hollow interior.

### Test 2 — Coupon

1. Change `output_mode` to `coupon`.
2. Render with F6.
3. Confirm the part contains approximately two complete teeth and remains hollow.

### Test 3 — Full assembly

1. Change `output_mode` to `assembly_preview`.
2. Preview with F5.
3. Confirm seven segments form one complete sprocket.

### Test 4 — Core

1. Change `output_mode` to `shell_core_preview`.
2. Preview with F5.
3. Confirm a concrete volume appears inside the printed shell.

### Test 5 — Scaling by configuration

Render each of these variants without using `scale()`:

- `POC_06IN_13T`
- `POC_24IN_21T`
- `POC_48IN_25T`

Confirm the console reports different pitch and outside diameters and that each design retains a proportional circular-pocket profile.

## Acceptance information to return

After local testing and GitHub upload, provide:

- repository URL;
- accepted commit SHA;
- OpenSCAD version;
- which test cases passed or failed;
- screenshots of the segment and assembly preview if a geometry issue appears.

The accepted commit becomes the source of truth for Batch 002.
