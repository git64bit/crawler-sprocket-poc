# Batch 003 — Continuous Open Valley

## Status

This package replaces the earlier uncommitted Batch 003 attempt. That attempt
widened only the shallow outside portion of a circular pocket and did not create
a demonstrably continuous bushing path.

The source of truth for this replacement remains accepted commit `530e5f2`.

## Change

The default `POC_24IN_19T` variant now uses `OPEN_VALLEY_STANDARD`.

Each valley is created with OpenSCAD `hull()` between:

1. the circular bushing seat; and
2. a larger exit circle located beyond the outside diameter.

Because both endpoint circles are wider than the nominal bushing, the hull
contains the complete radial sweep between them. The bushing does not need to
pass through a narrower neck.

## Default calculated geometry

For `POC_24IN_19T`:

| Quantity | Value |
|---|---:|
| Track pitch | 94.700 mm |
| Nominal bushing diameter | 48.000 mm |
| Valley throat width | 50.841 mm |
| Minimum throat clearance | 2.841 mm |
| Valley opening at tooth tips | 68.966 mm |
| Approximate tooth width at root | 43.859 mm |
| Approximate tooth width at tip | 31.346 mm |
| Outside diameter | 609.445 mm |

The profile therefore keeps a substantial tooth while making the outside
opening visibly and dimensionally larger than the nominal bushing.

## New fit-preview mode

`main.scad` starts with:

```scad
output_mode = "fit_preview";
```

This renders an open-top coupon and four translucent copies of one bushing:

- seated;
- 35 percent outward;
- 70 percent outward;
- completely outside the tooth tips.

The preview is a direct visual test of the requirement that the bushing has a
continuous path. It is not an exportable part.

## Acceptance test

1. Open `main.scad`.
2. Render `fit_preview` with F6.
3. Confirm no bushing position intersects either adjacent tooth.
4. Set `output_mode = "segment"` and render.
5. Confirm one tooth sits between two deep, open half-valleys.
6. Confirm the upper casting face remains completely open.
7. Set `output_mode = "coupon"` and render.
8. Confirm the same valley geometry appears in the printable coupon.

Do not commit this batch unless all eight checks pass.
