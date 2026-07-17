# Batch 004 — Idler Carrier and Casting Architecture

## Source of truth

Batch 004 is built from accepted commit `0b1205d`.

The accepted 19-tooth `open_valley` profile is unchanged. This batch addresses
only the first physical idler architecture around that profile.

## Purpose

The sprocket is an unpowered idler. It does not require a drive-torque path from
its hub to the teeth. The first architecture therefore separates the idler into:

1. nineteen cast tooth modules;
2. nineteen replaceable valley liners;
3. two rigid side plates;
4. one inner registration ring;
5. nineteen axial threaded rods; and
6. a reference metal hub and rotating shaft.

Bearings remain outside the wheel body on the chassis. There is no bearing or
bushing press fit in concrete or printed plastic.

## Cast tooth module

Each module retains one complete tooth and two half-valleys. It includes:

- one axial threaded-rod hole;
- half of the liner slot at each segment boundary; and
- a straight fiberglass chord reference behind the tooth root.

The cast module no longer needs to extend to the shaft. Its existing inner arc
registers against a separate inner ring.

## Replaceable valley liner

Each liner is centered on a valley, so it bridges the joint between two cast
modules. The liner restores the accepted valley surface and covers:

- the entry flank;
- the rounded seat; and
- the exit flank.

A straight inward retention tongue is captured by the side plates. The liner
slides axially into its slot before the second side plate is installed. No screw
head appears in the bushing path.

The first preset uses a 4 mm liner thickness and 0.6 mm nominal fit clearance.

## TPU mold

`tpu_mold` is a one-piece open-top mold for one cast module. It has:

- a 2.4 mm floor;
- 2.4 mm perimeter walls;
- molded forms for the liner half-slots; and
- a shallow locator socket for a separate smooth rod-core pin.

The mold is intended as flexible removable tooling, not as the permanent tooth
surface.

## Carrier

Two rigid side plates overlap the cast modules and the inward liner tongues.
Nineteen threaded rods clamp the assembly. The inner registration ring locates
the module inner arcs and maintains plate spacing.

The side plates include:

- nineteen module-rod holes;
- an eight-hole reference hub bolt circle; and
- a central clearance opening.

The side plate and hub dimensions are proof-of-concept placeholders, not bearing
or shaft specifications.

## Default calculated layout

For `POC_24IN_19T` with `IDLER_POC_A`:

| Quantity | Value |
|---|---:|
| Cast-module face width | 75.0 mm |
| Wear-liner thickness | 4.0 mm |
| Wear-liner height | 73.8 mm |
| Side-plate outside diameter | 504.5 mm |
| Module threaded-rod radius | 231.0 mm |
| Nominal module hole diameter | 10.0 mm |
| Liner retention-tail radial range | 242.3–260.3 mm |
| Side-plate overlap radius | 252.3 mm |
| Registration-ring outside diameter | 409.0 mm |
| Registration-ring inside diameter | 349.0 mm |
| Reference hub-flange diameter | 200.0 mm |
| Reference shaft diameter | 30.0 mm |

The plan-view calculation is stored in
`docs/reference/batch-004-plan-preview.png`. It is a geometry check, not an
OpenSCAD render.

## Reinforcement

`reinforcement_preview` shows one straight 6 mm fiberglass chord behind the
root of each tooth. It is only a placement reference. The module threaded rod
is separate from this reinforcement and remains removable.

## Output modes

| Mode | Purpose |
|---|---|
| `idler_assembly_preview` | Complete assembled first architecture |
| `idler_exploded_preview` | Separates plates and liners for inspection |
| `cast_module` | One cast tooth module |
| `wear_liner` | One replaceable valley liner |
| `tpu_mold` | One open-top removable casting mold |
| `side_plate` | One rigid carrier plate |
| `registration_ring` | Inner module-location and spacing ring |
| `hub_reference` | Non-production hub-flange reference |
| `rod_core_reference` | Reference geometry for the removable hole-forming pin |
| `reinforcement_preview` | One module with fiberglass placement reference |

## Acceptance test

1. Render `idler_assembly_preview` with F6.
2. Confirm there are 19 cast modules and 19 orange liners.
3. Confirm every liner bridges a joint between two modules.
4. Confirm the side plates stop below the working valley but overlap each
   liner's inward retention tongue.
5. Confirm the central shaft and hub do not require a press fit in concrete.
6. Render `idler_exploded_preview` and inspect the separate component layers.
7. Render `cast_module` and confirm one complete tooth, two half-valleys, one
   clamp hole, and two half-liner slots.
8. Render `wear_liner` and confirm a complete valley saddle with an inward
   retention tongue.
9. Render `tpu_mold` and confirm the entire casting face is open and the floor has a shallow rod-core locator socket.
10. Render `rod_core_reference` and confirm it passes through the nominal module hole.
11. Render `reinforcement_preview` and confirm the fiberglass chord is behind
    the tooth root and clear of the threaded-rod hole.

Do not commit the batch unless these checks pass.
