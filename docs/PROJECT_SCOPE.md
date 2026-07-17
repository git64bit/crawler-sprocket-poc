# Project Scope

## Purpose

Create a reusable OpenSCAD system capable of producing approximately 20–25
proof-of-concept crawler-frame idler variants.

The variants may differ in:

- physical size;
- track pitch;
- tooth count;
- bushing diameter;
- valley or engagement profile;
- cast-module geometry;
- wear-liner geometry;
- carrier and side-plate geometry; and
- printable mold segmentation.

## Current functional requirement

A model is successful when it can be generated from parameters, divided into
manufacturable parts, assembled around a separate carrier, and used to
demonstrate passive track engagement in both directions.

The idlers are not powered. Bearings are external to the wheel body. Concrete
or grout provides local backing in the tooth modules rather than a precision
bearing seat or a drive-torque path.

There is currently no requirement for:

- rated torque;
- service life;
- structural certification;
- production wear resistance;
- compatibility with commercial Caterpillar undercarriage parts; or
- a final commercial hub or bearing selection.

## Architecture

The system separates five concerns:

1. **Variant configuration** — track dimensions and selected profile.
2. **Profile generation** — the 2D tooth and valley outline.
3. **Idler architecture** — cast modules, wear liners, carrier plates, and
   registration geometry.
4. **Manufacturing output** — removable molds, individual parts, and previews.
5. **External hardware interface** — reference hub and shaft geometry without a
   press fit in printed or cast material.

This separation prevents a change in track profile from requiring a rewrite of
the carrier, mold, or hub-interface code.
