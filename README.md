# Crawler Sprocket POC

A parametric OpenSCAD project for proof-of-concept crawler sprockets made from segmented printed shells with a cast concrete core.

## Scope

The sole requirement at this stage is **functional proof of concept**:

- the tooth pockets must engage a matching conceptual track bushing;
- models must regenerate from parameters rather than global scaling;
- large sprockets must split into printable segments;
- the printed part must contain a connected casting cavity;
- the same codebase must support approximately 20–25 future variants and several profile families.

This repository does **not** claim production strength, fatigue life, wear resistance, vehicle safety, or compatibility with Caterpillar equipment. “Crawler” is used generically.

## Batch 001

Batch 001 establishes the project skeleton and a working geometry generator:

- three demonstration sizes;
- normalized profile presets;
- pitch-derived sprocket diameter;
- circular bushing-pocket profile matching the first concept image;
- hollow printed shell with top and bottom skins;
- concrete-core preview volume;
- automatic casting fill and vent openings;
- complete, segmented, and two-tooth coupon outputs;
- nominal bushing preview;
- geometry validation and dimensional console output.

The circular-pocket profile is intentionally simple. Generated entry and exit flanks belong in a later batch.

## Folder structure

```text
crawler-sprocket-poc/
├── main.scad
├── VERSION
├── config/
│   ├── profiles.scad
│   └── variants.scad
├── lib/
│   ├── indices.scad
│   ├── sprocket_math.scad
│   └── validation.scad
├── profiles/
│   └── circular_pocket.scad
├── parts/
│   ├── preview.scad
│   ├── segmentation.scad
│   └── sprocket.scad
├── docs/
│   ├── BATCH_001.md
│   ├── DESIGN_RULES.md
│   ├── PROJECT_SCOPE.md
│   └── reference/
│       └── first-attempt.png
├── exports/
└── renders/
```

## First run

1. Open `main.scad` in OpenSCAD.
2. Leave the initial settings:

   ```scad
   variant_name_selected = "POC_24IN_21T";
   output_mode = "segment";
   segment_index = 0;
   ```

3. Press **F5** for preview.
4. Press **F6** for render.
5. Export the segment as STL.
6. Change `output_mode` to `coupon` and render the two-tooth test piece.
7. Change `output_mode` to `assembly_preview` to inspect the full segmented ring.

## Available output modes

| Mode | Purpose |
|---|---|
| `full_solid` | Solid reference sprocket |
| `full_shell` | Complete hollow printed shell |
| `segment` | One printable shell segment |
| `coupon` | Two-tooth fit and casting test |
| `core` | Volume intended to become concrete |
| `assembly_preview` | All shell segments assembled |
| `shell_core_preview` | Transparent shell with concrete core |

Do not export with `show_bushings = true`; the bushing cylinders are only reference geometry.

## Adding a variant

Add one row to `config/variants.scad`. Do not use `scale()` on a completed sprocket.

The controlling dimensions are:

- track pitch;
- bushing outside diameter;
- tooth count;
- link gap and side clearance;
- central opening;
- printed wall and skin dimensions;
- segment count and usable printer width;
- selected profile preset.

The pitch diameter is calculated from:

```text
D_p = pitch / sin(180 / teeth)
```

## Adding a profile

For Batch 001, all presets use the `circular_pocket` generator. Each preset changes normalized values for:

- radial pocket clearance;
- tooth-tip height;
- pocket-center radial shift.

Later profile generators should be added as separate files under `profiles/`, then dispatched from `sprocket_profile_2d()`.

## Repository rule

The GitHub commit accepted after testing becomes the single source of truth for the next batch. Future changes should be delivered in small, testable batches.
