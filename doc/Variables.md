
# Main variables

Note: FreeFEM++ does not supported the underscore character is variables names,
so uniform camel case variables have been adopted throughout all the 
Gmsh/FreeFEM++/Octave code.

## General parameters

Variable        | Unit |     Range    | Description
:---------------|------|--------------|---------------------------------------------------------
c0              | m/s  |  299792458   | Speed of light in free-space

## Input parameters

Variable        | Unit |     Range    | Description
:---------------|------|--------------|---------------------------------------------------------
isSrc           |  -   |  0/1         | Whether to mesh the source as a spherical surface
isCyl           |  -   |  0/1         | Whether to include the cylinder
isPart          |  -   |  0/1         | Whether to include the partition
isSabine        |  -   |  0/1         | Whether to use Sabine or Jing & Xiang absorption factor
Lx              |  m   |  >0          | Cavity size in x-direction
Ly              |  m   |  >0          | Cavity size in y-direction
Lz              |  m   |  >0          | Cavity size in z-direction
wallAE          |  -   |  >=0         | Absorption efficiency of walls
partX           |  m   | >0, < Lx     | x-coordinate of partition
partThickness   |  m   | >0, <<Lx     | Partition thickness
partAE          |  -   | >=0          | Absorption efficiency of partition
holeWidth       |  m   | >0, < Ly     | Aperture width
cylXWithPart    |  m   | >partX, < Lx | x-coordinate of cylinder if partition is present
cylXWithoutPart |  m   | >partX, < Lx | x-coordinate of cylinder if partition is not present
cylY            |  m   | >0, < Ly     | y-coordinate of cylinder
cylRadius       |  m   | >0           | Cylinder radius
cylAE           |  -   | >-0          | Absorption efficiency of cylinder
srcX            |  m   | >0, <partX   | x-coordinates of source
srcY            |  m   | >0, < Ly     | y-coordinates of source
srcZ            |  m   | >0, < Lz     | z-coordinates of source
srcRadius       |  m   | >0           | Source radius if meshed as sphere
srcTRP          |  W   | >0           | Total radiated power of source


## Derived parameters

Variable        | Unit  | Description
:---------------|-------|--------------------------------------------------------
srcArea         | m^2   | Surface source surface area
srcVolume       | m^3   | Surface source volume
srcExitance     | W/m^2 | Surface source exitance
wallAF          |  -    | Wall absorption factor
partAF          |  -    | Partition absorption factor
cylAF           |  -    | Cylinder absorption factor
holeArea        |  m^2  | hole area
holeTCS         |  m^2  | hole average transmission cross-section
cylXSArea       |  m^2  | cylinder cross-sectional area
cylArea         |  m^2  | cylinder surface area
cylVolume       |  m^3  | Cylinder volume
partArea        |  m^2  | Partition total surface area
partVolume      |  m^3  | Partition volume
wallArea        |  m^2  | Single cavity wall area
wallMFP         |  m    | Single cavity wall scattering mean-free-path
wallD           | m^2/s | Single cavity wall diffusivity
wallACS         |  m^2  | Single cavity wall average absorption cross-section
Lx1             |   m   | Length in x-direction of sub-cavity 1
wallArea1       |  m^2  | Sub-cavity 1 wall area
partArea1       |  m^2  | Area of partition in sub-cavity 1
Lx2             |   m   | Length in x-direction of sub-cavity 2
wallArea2       |  m^2  | Sub-cavity 2 wall area
partArea2       |  m^2  | Area of partition in sub-cavity 2
wallMFP1        |   m   | Sub-cavity 1 wall scattering mean-free-path
wallD1          | m^2/s | Sub-cavity 1 wall diffusivity
wallACS1        |  m^2  | Sub-cavity 1 wall average absorption cross-section
wallMFP2        |   m   | Sub-cavity 2 wall scattering mean-free-path
wallD2          | m^2/s | Sub-cavity 2 wall diffusivity
wallACS2        |  m^2  | Sub-cavity 2 wall average absorption cross-section
partACS1        |  m^2  | Sub-cavity 1 partition average absorption cross-section
partACS2        |  m^2  | Sub-cavity 2 partition average absorption cross-section
cylACS          |  m^2  | Cylinder average absorption cross-section
cylMFP          |   m   | Cylinder scattering mean-free-path [1]
cylD            | m^2/s | Cylinder diffusivity
D1              | m^2/s | Overall diffusivity for x <= partX [2]
D2              | m^2/s | Overall diffusivity for > partX [2]

[1] Changes depending on whether partition is present or not.
[2] Valid in all cases whether partition is present or not

## Kantorovich parameters

Variable        | Unit | Description
:---------------|------|--------------------------------------------------------
zetaz1          |  /m  | Vertical profile coefficient in sub-cavity 1
Z21             |  m   | Integral of Z(z)^2 in sub-cavity 1
Z11             |  m   | Integral of Z(z) in sub-cavoty 1
d2Zdz21         |  /m  | Integral of d^2Z/dz^2 in sub-cavity 1
Zho21           |  -   | Z(z) at half height of sub-cavity 1
Dp1             | m/s  | Sub-cavity 1 reduced diffusivity
LambdaZ1        |  /s  | Sub-cavity 1 reduced energy loss rate
wallAFp1        |  -   | Sub-cavity 1 reduced side wall absorption factor
partAFp1        |  -   | Sub-cavity 1 reduced partition absorption factor
zetaz2          |  /m  | Vertical profile coefficient in sub-cavity 2
Z22             |  m   | Integral of Z(z)^2 in sub-cavity 2
Z12             |  m   | Integral of Z(z) in sub-cavoty 2
d2Zdz22         |  /m  | Integral of d^2Z/dz^2 in sub-cavity 2
Zho22           |  -   | Z(z) at half height of sub-cavity 2
Dp2             | m/s  | Sub-cavity 2 reduced diffusivity
LambdaZ2        |  /s  | Sub-cavity 2 reduced energy loss rate
wallAFp2        |  -   | Sub-cavity 2 reduced side wall absorption factor
partAFp2        |  -   | Sub-cavity 2 reduced partition absorption factor

## Power balance model parameters

Variable        | Unit  | Description
:---------------|-------|--------------------------------------------------------
ACS             |  m^2  | Single cavity total average absorption cross-section
Spwb            | W/m^2 | Single cavity average scalar power density
wpwb            | J/m^3 | Single cavity average volume energy density
ACS1            |  m^2  | Sub-cavity 1 total average absorption cross-section
ACS2            |  m^2  | Sub-cavity 2 total average absorption cross-section
S1pwb           | W/m^2 | Sub-cavity 1 average scalar power density
S2pwb           | W/m^2 | Sub-cavity 2 average scalar power density
w1pwb           | J/m^3 | Sub-cavity 1 average volume energy density
w2pwb           | J/m^3 | Sub-cavity 2 average volume energy density

## Post-processed 

Variable        |   Unit   | Description
:---------------|----------|----------------------------------------------------------------
w               |  J/m^3   | Total 3D energy density field
wds             |  J/m^3   | Spurious direct 3D energy density field
wr              |  J/m^2   | Reverberant 3D energy density field
Jx              |  W/m^2   | x-component of total 3D energy density flux field
Jy              |  W/m^2   | y-component of total 3D energy density flux field
Jz              |  W/m^2   | z-component of total 3D energy density flux field
Jmag            |  W/m^2   | Magnitude of total 3D energy density flux field
Jdx             |  W/m^2   | x-component of direct 3D energy density flux field
Jdy             |  W/m^2   | y-component of direct 3D energy density flux field
Jdz             |  W/m^2   | z-component of direct 3D energy density flux field
Jdmag           |  W/m^2   | Magnitude of direct 3D energy density flux field
Jrx             |  W/m^2   | x-component of reverberant 3D energy density flux field
Jry             |  W/m^2   | y-component of reverberant 3D energy density flux field
Jrz             |  W/m^2   | z-component of reverberant 3D energy density flux field
Jrmag           |  W/m^2   | Magnitude of total 3D energy density flux field
S               |  W/m^2   | Total 3D power density field
Sr              |  W/m^2   | Reverberant 3D power density field
Delta           |    -     | Uniformity of 3D energy density 
Upsilon         |    -     | Anisotropy of 3D power density
SdB             | dB W/m^2 | Total 3D power density field in decibels
SrdB            | dB W/m^2 | Reverberant 3D power density field in decibels
DeltadB         |    dB    | Uniformity of 3D energy density in decibels
JdB             | dB W/m^2 | Magnitude of total 3D energy density flux field in decibels
UpsilondB       |    dB    | Anisotropy of 3D power density in decibels
w2              |  J/m^3   | Total 2D energy density field at half-height of cavity
w2ds            |  J/m^3   | Spurious direct 2D energy density field
w2r             |  J/m^2   | Reverberant 2D energy density field
J2x             |  W/m^2   | x-component of total 2D energy density flux field
J2y             |  W/m^2   | y-component of total 2D energy density flux field
J2mag           |  W/m^2   | Magnitude of total 2D energy density flux field
J2dx            |  W/m^2   | x-component of direct 2D energy density flux field
J2dy            |  W/m^2   | y-component of direct 2D energy density flux field
J2dmag          |  W/m^2   | Magnitude of direct 2D energy density flux field
J2rx            |  W/m^2   | x-component of reverberant 2D energy density flux field
J2ry            |  W/m^2   | y-component of reverberant 2D energy density flux field
J2rmag          |  W/m^2   | Magnitude of total 2D energy density flux field
S2              |  W/m^2   | Total 2D power density field
S2r             |  W/m^2   | Reverberant 2D power density field
Delta2          |    -     | Uniformity of 2D energy density 
Upsilon2        |    -     | Anisotropy of 2D power density
S2dB            | dB W/m^2 | Total 2D power density field in decibels
S2rdB           | dB W/m^2 | Reverberant 2D power density field in decibels
Delta2dB        |    dB    | Uniformity of 2D energy density in decibels
J2dB            | dB W/m^2 | Magnitude of total 2D energy density flux field in decibels
Upsilon2dB      |    dB    | Anisotropy of 2D power density in decibels
