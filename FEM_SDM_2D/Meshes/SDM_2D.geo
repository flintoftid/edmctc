//
// 2D CAD and mesh generation for Canonical Test Cases. 
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
// Cavity walls.
//

// Ordered set of points around perimeter of cavity floor in z = 0 plane.
If( isPart == 1 )
  P1 = newp;
  Point(P1) = { 0.0                            , 0.0            , 0.0 , wallMeshSize };
  P2 = newp;
  Point(P2) = { 0.5 * Lx - 0.5 * partThickness , 0.0            , 0.0 , wallMeshSize };
  P3 = newp;
  Point(P3) = { 0.5 * Lx - 0.5 * partThickness , Ly - holeWidth , 0.0 , wallMeshSize };
  P4 = newp;
  Point(P4) = { 0.5 * Lx + 0.5 * partThickness , Ly - holeWidth , 0.0 , wallMeshSize };
  P5 = newp;
  Point(P5) = { 0.5 * Lx + 0.5 * partThickness , 0.0            , 0.0 , wallMeshSize };
  P6 = newp;
  Point(P6) = { Lx                             , 0.0            , 0.0 , wallMeshSize };
  P7 = newp;
  Point(P7) = { Lx                             , Ly             , 0.0 , wallMeshSize };
  P8 = newp;
  Point(P8) = { 0.0                            , Ly             , 0.0 , wallMeshSize };
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

All[] += { LL1[] };

Physical Line("wall") = { LL1 };

//
// Cylinder perimeter.
//

If( isCyl == 1 )

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
  
  Physical Line("cylinder") = { LL2 };
  All[] += { LL2[] };
  
EndIf

//
// Source perimeter (for line source).
//

If( isSrc == 1 )

  PSC = newp;
  Point(PSC) = { srcX             , srcY             , 0.0 , srcMeshSize };
  PS1 = newp;
  Point(PS1) = { srcX + srcRadius , srcY             , 0.0 , srcMeshSize };
  PS2 = newp;
  Point(PS2) = { srcX             , srcY + srcRadius , 0.0 , srcMeshSize };
  PS3 = newp;
  Point(PS3) = { srcX - srcRadius , srcY             , 0.0 , srcMeshSize };
  PS4 = newp;
  Point(PS4) = { srcX             , srcY - srcRadius , 0.0 , srcMeshSize };
  LS1 = newl;
  Circle(LS1) = { PS1 , PSC , PS2 };
  LS2 = newl;
  Circle(LS2) = { PS2 , PSC , PS3 };
  LS3 = newl;
  Circle(LS3) = { PS3 , PSC , PS4 };
  LS4 = newl;
  Circle(LS4) = { PS4 , PSC , PS1 };
  LL3 = newll;
  Line Loop(LL3) = { LS1 , LS2 , LS3 , LS4 };
  
  Physical Line("source") = { LL3 };
  All[] += { LL3[] };
  
EndIf

//
// Cavity area.
//

S1 = news;
Plane Surface(S1) = { All[] };
Physical Surface( "cavity" ) = { S1 };

// Point source.
If( isSrc == 0 )
  PSC = newp;
  Point(PSC) = { srcX           , srcY           , 0.0 , srcMeshSize };
  Point{PSC} In Surface {S1};
EndIf
