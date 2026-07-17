# Crawler Sprocket POC

A parametric OpenSCAD project for proof-of-concept crawler sprockets made from segmented printed shells with a cast concrete core.

## Scope

The sole requirement at this stage is **functional proof of concept**:

- a nominal track bushing must have a continuous path into and out of each valley;
- models must regenerate from parameters rather than global scaling;
- large sprockets must split into printable segments;
- each printed shell must have a connected cavity and a completely open upper face;
- concrete must remain accessible for pouring, leveling, adding, removing, and manual balancing;
- the same codebase must support approximately 20–25 future variants and several profile families.

This repository does **not** claim production strength, fatigue life, wear resistance, vehicle safety, or compatibility with Caterpillar equipment. “Crawler” is used generically.

## Current batch

Batch 003 replaces the rejected enclosed-pocket approach with an `open_valley`
profile.

The new valley is generated as the convex hull of:

- a circular bushing seat centered on the pitch circle; and
- a larger exit circle located completely outside the tooth tips.

This creates a continuous swept opening. The bushing is no longer surrounded by
a circular pocket with a shallow slit added to its outside.

The default 24-inch proof-of-concept remains:

- 19 teeth;
- 19 identical one-tooth segments;
- an open upper casting face;
- one bottom skin;
- no separate fill or vent ports.

See:

- `docs/BATCH_001.md`
- `docs/BATCH_002.md`
- `docs/BATCH_003.md`
- `docs/DESIGN_RULES.md`
- `docs/PROJECT_SCOPE.md`
- `docs/GITHUB_WEB_UPLOAD.md`

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
│   ├── open_valley.scad
│   └── rounded_lobe.scad
├── parts/
│   ├── preview.scad
│   ├── segmentation.scad
│   └── sprocket.scad
├── docs/
│   ├── BATCH_001.md
│   ├── BATCH_002.md
│   ├── BATCH_003.md
│   ├── DESIGN_RULES.md
│   ├── GITHUB_WEB_UPLOAD.md
│   ├── PROJECT_SCOPE.md
│   └── reference/
├── exports/
└── renders/
```

## First run

1. Open `main.scad` in OpenSCAD.
2. Leave the initial settings:

   ```scad
   variant_name_selected = "POC_24IN_19T";
   output_mode = "fit_preview";
   ```

3. Press **F5**, then **F6**.
4. Confirm that four translucent bushing positions form an unobstructed radial path through the center valley.
5. Change `output_mode` to `segment` and render again.
6. Confirm the upper casting face remains open.
7. Change `output_mode` to `coupon` and render again.

Do not export `fit_preview`; it contains reference bushings.

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
| `fit_preview` | Coupon plus a four-position bushing travel check |

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

Profile presets are stored in `config/profiles.scad`. Profile generators are stored separately under `profiles/` and dispatched from `sprocket_profile_2d()`.

Current generators:

- `circular_pocket` — Batch 001 reference geometry;
- `rounded_lobe` — rejected Batch 002 geometry, retained for comparison;
- `open_valley` — current functional proof-of-concept geometry.

## Repository rule

The GitHub commit accepted after testing becomes the single source of truth for the next batch. Future changes are delivered in small, testable batches.
