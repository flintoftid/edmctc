//
// 3D CAD and mesh generation for Canonical Test Cases. 
//
// (c) 2016-2017, Ian D. Flintoft <ian.flintoft@googlemail.com>
//
// This file is part of the Electromagnetic Diffusion Model (EDM) 
// Canonical Example Suite [Flintoft2017,flintoft2017b].
//
// The EDM Canonical Example Suite is free software: you can 
// redistribute it and/or modify it under the terms of the GNU 
// General Public License as published by the Free Software 
// Foundation, either version 3 of the License, or (at your option) 
// any later version.
//
// The EDM Canonical Example Suite is distributed in the hope that 
// it will be useful, but WITHOUT ANY WARRANTY; without even the 
// implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
// PURPOSE.  See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with  The EDM Canonical Example Suite.  If not, 
// see <http://www.gnu.org/licenses/>.
//
// References:
//
// [Flintoft2017] I D Flintoft, A C Marvin, F I Funn, L Dawson, X Zhang,
// M P Robinson, and J F Dawson, "Evaluation of the diffusion equation for
// modelling reverberant electromagnetic fields", IEEE Transactions on Electromagnetic
// Compatibility, vol. 59, no. 3, pp. 760–769, 2017. DOI: 10.1109/TEMC.2016.2623356.
//
// [Flintoft2017b] I D Flintoft and J F Dawson, “3D electromagnetic diffusion models 
// for reverberant environments”, 2017 International Conference on Electromagnetics 
// in Advanced Applications (ICEAA2017), Verona, Italy, pp. 11-15 Sep. 2017.
//

// Macros.
Include "../../geo/macros.geo";

// Model parameters.
Include "parameters.geo";

// Location of cylinder.
If( isPart == 1 )
  cylX = cylXWithPart;
Else
  cylX = cylXWithoutPart;
EndIf

// Mesh sizes
wallMeshSize = 0.02;  // Wall mesh size [m].
cylMeshSize = 0.02;   // Cylinder mesh size [m].
srcMeshSize = 0.005;  // Source mesh size [m].

// Array to collect all surfaces.
All[] = {};

//
// Cavity.
//

// Ordered set of points around perimeter of cavity floor in z = 0 plane.
If( isPart == 1 )
  P1 = newp;
  Point(P1) = { 0.0                , 0.0    , 0.0 , wallMeshSize };
  P2 = newp;
  Point(P2) = { partX - 0.5 * partThickness , 0.0    , 0.0 , wallMeshSize };
  P3 = newp;
  Point(P3) = { partX - 0.5 * partThickness , Ly - holeWidth , 0.0 , wallMeshSize };
  P4 = newp;
  Point(P4) = { partX + 0.5 * partThickness , Ly - holeWidth , 0.0 , wallMeshSize };
  P5 = newp;
  Point(P5) = { partX + 0.5 * partThickness , 0.0    , 0.0 , wallMeshSize };
  P6 = newp;
  Point(P6) = { Lx                 , 0.0    , 0.0 , wallMeshSize };
  P7 = newp;
  Point(P7) = { Lx                 , Ly     , 0.0 , wallMeshSize };
  P8 = newp;
  Point(P8) = { 0.0                , Ly     , 0.0 , wallMeshSize };
  points = { P1:P8 };
Else
  P1 = newp;
  Point(P1) = { 0.0 , 0.0 , 0.0 , wallMeshSize };
  P2 = newp;
  Point(P2) = { Lx  , 0.0 , 0.0 , wallMeshSize };
  P3 = newp;
  Point(P3) = { Lx  , Ly  , 0.0 , wallMeshSize };
  P4 = newp;
  Point(P4) = { 0.0 , Ly  , 0.0 , wallMeshSize };
  points = { P1:P4 };
EndIf

// Construct perimeter line loop
lines[] = {};
n = #points[];

For i In {0:n-2}
  lines[i] = newl;
  Line(lines[i]) = { points[i] , points[i+1] };
EndFor

lines[n-1] = newl;
Line(lines[n-1]) = { points[n-1] , points[0] };

LL1 = newll;
Line Loop(LL1) = { lines[] };

// Construct floor surface.
S1 = news;

If( isCyl == 1 )
  // Perimeter of cylinder's projection onto floor.
  PCC = newp;
  Point(PCC) = { cylX             , cylY             , 0.0 , cylMeshSize };
  PC1 = newp;
  Point(PC1) = { cylX + cylRadius , cylY             , 0.0 , cylMeshSize };
  PC2 = newp;
  Point(PC2) = { cylX             , cylY + cylRadius , 0.0 , cylMeshSize };
  PC3 = newp;
  Point(PC3) = { cylX - cylRadius , cylY             , 0.0 , cylMeshSize };
  PC4 = newp;
  Point(PC4) = { cylX             , cylY - cylRadius , 0.0 , cylMeshSize };
  LC1 = newl;
  Circle(LC1) = { PC1 , PCC , PC2 };
  LC2 = newl;
  Circle(LC2) = { PC2 , PCC , PC3 };
  LC3 = newl;
  Circle(LC3) = { PC3 , PCC , PC4 };
  LC4 = newl;
  Circle(LC4) = { PC4 , PCC , PC1 };
  LL2 = newll;
  Line Loop(LL2) = { LC1 , LC2 , LC3 , LC4 };
  Plane Surface(S1) = { LL1 , LL2 };
Else
  Plane Surface(S1) = { LL1 };
EndIf

// Extrude floor upwards to form 3D cavity.
ps[] = Extrude{ 0 , 0 , Lz }{ Surface{S1}; };

// Identify which surfaces belong to walls and cylinder.
// Ensure outwards normal vector. Extrude always gives
// flipped normal on floor compared to side and top.
If( isCyl == 1 )

  If( isPart == 1 )
    Physical Surface("walls") = { -S1 , ps[{2}] , ps[{6:(#ps[]-5)}] , ps[0] };
    Physical Surface("partition") = { ps[{3:5}] };
    Physical Surface("cylinder") = { ps[{(#ps[]-4):(#ps[]-1)}] };
  Else
    Physical Surface("walls") = { -S1 , ps[{2:(#ps[]-5)}] , ps[0] };
    Physical Surface("cylinder") = { ps[{(#ps[]-4):(#ps[]-1)}] };
  EndIf
  
Else

  If( isPart == 1 )
    Physical Surface("walls") = { -S1 , ps[{2}] , ps[{6:(#ps[]-1)}] , ps[0] };
    Physical Surface("partition") = { ps[{3:5}] };
  Else
    Physical Surface("walls") = { -S1 , ps[{2:(#ps[]-1)}] , ps[0] };
  EndIf
   
EndIf

All[] += { -S1 , ps[{2:(#ps[]-1)}] , ps[0]  };

// Source.
If( isSrc == 1 )
  sphereMeshSize = srcMeshSize;
  spherex = srcX;
  spherey = srcY;
  spherez = srcZ;
  spherer = srcRadius;
  Call MakeSphereIN;
  Physical Surface("source") = { SSPHERE[] };
  // Add source surface to list of boundary surfaces.
  All[] += { SSPHERE[] };
EndIf

//
// Volume mesh.
//

SL_1 = newsl;
Surface Loop(SL_1) = { All[] };
V_1 = newv;
Volume(V_1) = { SL_1 };

// Don't know why but....
If( isSrc == 1 )
  Physical Volume("cavity") = { V_1 };
Else
  Physical Volume("cavity") = { 1 };
EndIf
