# Crawler Sprocket POC

A parametric OpenSCAD project for proof-of-concept crawler sprockets made from segmented printed shells with a cast concrete core.

## Scope

The sole requirement at this stage is **functional proof of concept**:

- tooth pockets must engage a matching conceptual track bushing;
- models must regenerate from parameters rather than global scaling;
- large sprockets must split into printable segments;
- each printed shell must have a connected cavity and a completely open upper face;
- concrete must be accessible for pouring, leveling, adding, removing, and manual balancing;
- the same codebase must support approximately 20–25 future variants and several profile families.

This repository does **not** claim production strength, fatigue life, wear resistance, vehicle safety, or compatibility with Caterpillar equipment. “Crawler” is used generically.

## Current batch

Batch 002 replaces the default block-like circular-pocket tooth with a thick,
tapered, rounded tooth family and changes the default 24-inch example from 21
to 19 teeth.

The default 19-tooth model uses 19 identical one-tooth segments. This avoids
unequal segment shapes when using a prime tooth count.

All shell, segment, and coupon outputs now have:

- one bottom skin;
- perimeter and pocket walls;
- no top skin;
- no separate fill or vent ports.

The complete upper face is the casting and balancing opening.

See:

- `docs/BATCH_001.md`
- `docs/BATCH_002.md`
- `docs/DESIGN_RULES.md`
- `docs/PROJECT_SCOPE.md`

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
│   ├── circular_pocket.scad
│   └── rounded_lobe.scad
├── parts/
│   ├── preview.scad
│   ├── segmentation.scad
│   └── sprocket.scad
├── docs/
│   ├── BATCH_001.md
│   ├── BATCH_002.md
│   ├── DESIGN_RULES.md
│   ├── PROJECT_SCOPE.md
│   └── reference/
│       ├── first-attempt.png
│       └── batch-001-render.png
├── exports/
└── renders/
```

## First run

1. Open `main.scad` in OpenSCAD.
2. Leave the initial settings:

   ```scad
   variant_name_selected = "POC_24IN_19T";
   output_mode = "segment";
   segment_index = 0;
   ```

3. Press **F5** for preview.
4. Press **F6** for render.
5. Confirm the tooth tapers toward a rounded tip.
6. Confirm the entire upper face is open.
7. Export the segment as STL.
8. Change `output_mode` to `coupon` and repeat.
9. Change `output_mode` to `assembly_preview` to inspect all 19 segments.

## Available output modes

| Mode | Purpose |
|---|---|
| `full_solid` | Solid reference sprocket |
| `full_shell` | Complete open-top printed shell |
| `segment` | One open-top printable shell segment |
| `coupon` | Open-top two-tooth fit and casting test |
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
- printed wall and bottom skin;
- segment count and usable printer width;
- selected profile preset.

The pitch diameter is calculated from:

```text
D_p = pitch / sin(180 / teeth)
```

## Adding a profile

Profile presets are stored in `config/profiles.scad`. Profile generators are
stored separately under `profiles/` and dispatched from
`sprocket_profile_2d()`.

Batch 002 contains:

- `circular_pocket` — the Batch 001 reference geometry;
- `rounded_lobe` — a separately generated thick tooth with tapered sides and a rounded tip.

## Repository rule

The GitHub commit accepted after testing becomes the single source of truth for the next batch. Future changes are delivered in small, testable batches.
