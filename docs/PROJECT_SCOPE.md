# Project Scope

## Purpose

Create a reusable OpenSCAD system capable of producing approximately 20–25 proof-of-concept crawler-frame sprocket variants.

The variants may differ in:

- physical size;
- track pitch;
- tooth count;
- bushing diameter;
- tooth-pocket or engagement profile;
- printed segment count;
- shell and casting geometry.

## Current functional requirement

A model is successful when it can be generated, segmented, printed as a shell, assembled, filled with a cast material, and used to demonstrate mechanical engagement at low speed and low consequence.

There is currently no requirement for:

- rated torque;
- service life;
- structural certification;
- road or work-site operation;
- production wear resistance;
- compatibility with commercial Caterpillar undercarriage parts.

## Architecture

The system separates four concerns:

1. **Variant configuration** — dimensions and selected profile.
2. **Profile generation** — the 2D tooth and pocket outline.
3. **Part construction** — solid body, shell, cavity, and ports.
4. **Manufacturing output** — segments, coupons, and previews.

This separation prevents a change in tooth profile from requiring a rewrite of casting or segmentation code.
