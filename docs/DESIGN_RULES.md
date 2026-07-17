# Design Rules

1. Do not use global `scale()` to create a new sprocket variant.
2. Track pitch and tooth count determine pitch diameter.
3. Bushing diameter and profile clearance determine pocket radius.
4. Axial face width comes from link gap minus side clearances.
5. Printed wall and skin dimensions remain explicit manufacturing inputs.
6. Tooth profiles are normalized to pitch where practical.
7. Profile generation remains separate from shell and segment generation.
8. Every new variant must render as a full shell, one segment, and a coupon.
9. Segment count must fit the configured usable print-bed width.
10. Demonstration dimensions must not be described as commercial specifications.
11. The concrete cavity must remain connected across an assembled set of segments.
12. Each development batch must be small enough to test before the next batch begins.
