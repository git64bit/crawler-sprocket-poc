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

Batch 004 keeps the accepted 19-tooth `open_valley` profile and adds the first
complete passive-idler architecture.

The new assembly separates:

- cast tooth modules;
- replaceable valley liners;
- a removable open-top TPU mold;
- two rigid side plates;
- an inner registration ring;
- threaded clamping rods; and
- a reference metal hub and rotating shaft.

Bearings remain external to the idler body. No press fit is required in concrete
or printed plastic.

See:

- `docs/BATCH_001.md`
- `docs/BATCH_002.md`
- `docs/BATCH_003.md`
- `docs/BATCH_004.md`
- `docs/IDLER_ARCHITECTURE.md`
- `docs/DESIGN_RULES.md`
- `docs/PROJECT_SCOPE.md`
- `docs/GITHUB_WEB_UPLOAD.md`

## Folder structure

```text
crawler-sprocket-poc/
├── main.scad
├── VERSION
├── config/
│   ├── idler_architectures.scad
│   ├── profiles.scad
│   └── variants.scad
├── lib/
│   ├── idler_math.scad
│   ├── indices.scad
│   ├── sprocket_math.scad
│   └── validation.scad
├── profiles/
│   ├── circular_pocket.scad
│   ├── open_valley.scad
│   └── rounded_lobe.scad
├── parts/
│   ├── idler_architecture.scad
│   ├── preview.scad
│   ├── segmentation.scad
│   └── sprocket.scad
├── docs/
│   ├── BATCH_001.md
│   ├── BATCH_002.md
│   ├── BATCH_003.md
│   ├── BATCH_004.md
│   ├── DESIGN_RULES.md
│   ├── IDLER_ARCHITECTURE.md
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
   output_mode = "idler_assembly_preview";
   ```

3. Press **F5**, then **F6**.
4. Confirm the 19 gray cast modules, 19 orange valley liners, two side plates,
   inner registration ring, threaded-rod references, hub references, and shaft.
5. Change `output_mode` to `idler_exploded_preview` and inspect the component
   separation.
6. Test `cast_module`, `wear_liner`, and `tpu_mold` individually.

Preview and reference modes are not exportable production hardware.

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
| `idler_assembly_preview` | Complete Batch 004 idler architecture |
| `idler_exploded_preview` | Separated architecture inspection |
| `cast_module` | One cast tooth module |
| `wear_liner` | One replaceable valley saddle |
| `tpu_mold` | One open-top removable mold |
| `side_plate` | One rigid carrier plate |
| `registration_ring` | Inner module registration and spacing ring |
| `hub_reference` | Non-production hub reference |
| `rod_core_reference` | Reference pin for the molded module hole |
| `reinforcement_preview` | Module with fiberglass placement reference |

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
