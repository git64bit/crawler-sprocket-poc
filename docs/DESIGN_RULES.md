# Design Rules

1. Do not use global `scale()` to create a new sprocket variant.
2. Track pitch and tooth count determine pitch diameter.
3. Bushing diameter and profile clearance determine pocket radius.
4. Axial face width comes from link gap minus side clearances.
5. Printed wall and bottom-skin dimensions remain explicit manufacturing inputs.
6. The upper casting face remains completely open for pouring and balancing.
7. Tooth profiles are normalized to pitch where practical.
8. Profile generation remains separate from shell and segment generation.
9. Every new variant must render as a full shell, one segment, and a coupon.
10. Segment count must fit the configured usable print-bed width.
11. Demonstration dimensions must not be described as commercial specifications.
12. The concrete cavity must remain connected across an assembled set of segments.
13. Fewer teeth do not automatically make a tooth stronger; tooth width and shape
    remain explicit profile parameters.
14. Prime tooth counts require either unequal multi-tooth segments or one segment
    per tooth. Prefer identical one-tooth segments for the current POC.
15. Every functional valley must provide a continuous bushing path; a widened outer slit alone is not sufficient.
16. Every new profile must include a direct fit-preview or equivalent interference check.
17. Each development batch must be small enough to test before the next batch begins.
