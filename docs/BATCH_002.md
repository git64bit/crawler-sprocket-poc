# Batch 002 — Rounded Tooth and Open Casting Face

## Source of truth

Built from accepted commit:

```text
c28a8f44132938b4fd2c015b0f0ff771827b9f3d
```

## Problem confirmed

The Batch 001 circular-pocket profile subtracts pockets from a complete
outside-diameter disk. The remaining teeth therefore resemble broad blocks
with nearly radial sides.

The screenshot received after Batch 001 testing is stored at:

```text
docs/reference/batch-001-render.png
```

## Delivered

- Added the `rounded_lobe` profile generator.
- Added the `ROUNDED_THICK` profile preset.
- Replaced the default 24-inch example with `POC_24IN_19T`.
- Retained an approximately 24-inch outside diameter by changing conceptual
  track pitch with the tooth count.
- Uses 19 identical one-tooth segments for the 19-tooth example.
- Removed the top skin from all shell, segment, and coupon outputs.
- Removed casting ports from generated geometry because the entire upper face
  is now the fill, leveling, and balancing opening.
- Retained the Batch 001 circular-pocket profiles for comparison.

## Test procedure

### Test 1 — New one-tooth segment

1. Open `main.scad`.
2. Keep `variant_name_selected = "POC_24IN_19T"`.
3. Keep `output_mode = "segment"`.
4. Render with F6.
5. Confirm the segment contains one tapered, rounded tooth between two half
   pockets.
6. Confirm the complete upper face is open and only the bottom skin remains.

### Test 2 — Coupon

1. Change `output_mode` to `coupon`.
2. Render with F6.
3. Confirm the coupon has approximately two complete rounded teeth.
4. Confirm the casting cavity is open across the upper face.

### Test 3 — Assembly

1. Change `output_mode` to `assembly_preview`.
2. Preview with F5.
3. Confirm 19 identical segments form one complete sprocket.
4. Confirm every tooth is tapered rather than block-shaped.

### Test 4 — Core access

1. Change `output_mode` to `shell_core_preview`.
2. Preview with F5.
3. Confirm the concrete preview reaches the open upper face.
4. Confirm the shell remains visible around the inner opening, outer profile,
   pockets, and bottom.

### Test 5 — Bushing relationship

1. Set `show_bushings = true`.
2. Use `output_mode = "assembly_preview"`.
3. Confirm each nominal bushing is centered in one circular pocket.
4. Return `show_bushings` to `false` before STL export.

## Acceptance information to return

- Pass or fail for Tests 1–5.
- OpenSCAD version.
- Screenshot of the one-tooth segment.
- Screenshot of the two-tooth coupon.
- Accepted GitHub commit SHA.

Do not proceed to segment joints or additional tooth families until this batch
is accepted.
