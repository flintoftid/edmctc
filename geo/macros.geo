//
// Utility macros.
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

//
// Make a sphere of radius sphere centred on (spherex,spherey,spherez) 
//
// Inputs: spherex             - x-coordinate of centre
//         spherey             - z-coordinate of centre
//         spherez             - y-coordinate of centre
//         spherer         - sphere radius
//         sphereMeshSize - mesh size of sphere
//
// Outputs: SSPHERE[]     - array of surfaces.
//
Function MakeSphereON

  meshSize_NP = sphereMeshSize; // Mesh size at north pole.
  meshSize_EQ = sphereMeshSize; // Mesh size along equator.
  meshSize_SP = sphereMeshSize; // Mesh size at south pole.

  ORIGIN = newp;
  Point(ORIGIN) = { spherex           , spherey           , spherez           , meshSize_EQ };
  NP = newp;
  Point(NP)     = { spherex           , spherey           , spherez + spherer , meshSize_NP };
  SP = newp;
  Point(SP)     = { spherex           , spherey           , spherez - spherer , meshSize_SP };
  EQ0 = newp;
  Point(EQ0)    = { spherex + spherer , spherey           , spherez           , meshSize_EQ };
  EQ90 = newp;
  Point(EQ90)   = { spherex           , spherey + spherer , spherez           , meshSize_EQ };
  EQ180 = newp;
  Point(EQ180)  = { spherex - spherer , spherey           , spherez           , meshSize_EQ };
  EQ270 = newp;
  Point(EQ270)  = { spherex           , spherey - spherer , spherez           , meshSize_EQ };

  ARC_EQ1 = newl;
  Circle(ARC_EQ1)   = { EQ0   , ORIGIN , EQ90  };
  ARC_EQ2 = newl;
  Circle(ARC_EQ2)   = { EQ90  , ORIGIN , EQ180 };
  ARC_EQ3 = newl;  
  Circle(ARC_EQ3)   = { EQ180 , ORIGIN , EQ270 };
  ARC_EQ4 = newl;
  Circle(ARC_EQ4)   = { EQ270 , ORIGIN , EQ0   };
  ARC_NP0 = newl;
  Circle(ARC_NP0)   = { NP    , ORIGIN , EQ0   };
  ARC_NP90 = newl;
  Circle(ARC_NP90)  = { EQ90  , ORIGIN , NP    };
  ARC_NP180 = newl;
  Circle(ARC_NP180) = { EQ180 , ORIGIN , NP    };
  ARC_NP270 = newl;
  Circle(ARC_NP270) = { NP    , ORIGIN , EQ270 };
  ARC_SP0 = newl;
  Circle(ARC_SP0)   = { EQ0   , ORIGIN , SP    };
  ARC_SP90 = newl;
  Circle(ARC_SP90)  = { SP    , ORIGIN , EQ90  };
  ARC_SP180 = newl;
  Circle(ARC_SP180) = { SP    , ORIGIN , EQ180 };
  ARC_SP270 = newl;
  Circle(ARC_SP270) = { EQ270 , ORIGIN , SP    };

  LL_NPEQ1 = newll;
  Line Loop(LL_NPEQ1) = { -ARC_NP90 , -ARC_NP0 , -ARC_EQ1 };
  RS_NPEQ1 = news;
  Ruled Surface(RS_NPEQ1) = { -LL_NPEQ1 };
  LL_NPEQ2 = newll;
  Line Loop(LL_NPEQ2) = { -ARC_NP180 , -ARC_EQ2 , ARC_NP90 };
  RS_NPEQ2 = news;
  Ruled Surface(RS_NPEQ2) = { -LL_NPEQ2 };
  LL_NPEQ3 = newll;
  Line Loop(LL_NPEQ3) = { -ARC_EQ3 , ARC_NP180 , ARC_NP270 };
  RS_NPEQ3 = news;
  Ruled Surface(RS_NPEQ3) = { -LL_NPEQ3 };
  LL_NPEQ4 = newll;
  Line Loop(LL_NPEQ4) = { -ARC_EQ4 , ARC_NP0 , -ARC_NP270 };
  RS_NPEQ4 = news;
  Ruled Surface(RS_NPEQ4) = { -LL_NPEQ4 };
  LL_SPEQ1 = newll;
  Line Loop(LL_SPEQ1) = { -ARC_SP90 , -ARC_SP0 , ARC_EQ1 };
  RS_SPEQ1 = news;
  Ruled Surface(RS_SPEQ1) = { -LL_SPEQ1 };
  LL_SPEQ2 = newll;
  Line Loop(LL_SPEQ2) = { ARC_EQ2 , ARC_SP90 , -ARC_SP180 };
  RS_SPEQ2 = news;
  Ruled Surface(RS_SPEQ2) = { -LL_SPEQ2 };
  LL_SPEQ3 = newll;
  Line Loop(LL_SPEQ3) = { ARC_SP180 , ARC_EQ3 , ARC_SP270 };
  RS_SPEQ3 = news;
  Ruled Surface(RS_SPEQ3) = { -LL_SPEQ3 };
  LL_SPEQ4 = newll;
  Line Loop(LL_SPEQ4) = { -ARC_SP270 , ARC_EQ4 , ARC_SP0 };
  RS_SPEQ4 = news;
  Ruled Surface(RS_SPEQ4) = { -LL_SPEQ4 };

  SSPHERE[] = { -RS_NPEQ1 , -RS_NPEQ2 , -RS_NPEQ3 , -RS_NPEQ4 , -RS_SPEQ1 , -RS_SPEQ2 , -RS_SPEQ3 , -RS_SPEQ4 };
 
Return

//
// Make a sphere of radius spherer centred on (spherex,spherey,spherez) 
//
// Normal vector points inwards!
//
// Inputs: spherex             - x-coordinate of centre
//         spherey             - z-coordinate of centre
//         spherez             - y-coordinate of centre
//         spherer         - sphere radius
//         sphereMeshSize - mesh size of sphere
//
// Outputs: SSPHERE[]     - array of surfaces.
//
Function MakeSphereIN

  meshSize_NP = sphereMeshSize; // Mesh size at north pole.
  meshSize_EQ = sphereMeshSize; // Mesh size along equator.
  meshSize_SP = sphereMeshSize; // Mesh size at south pole.

  ORIGIN = newp;
  Point(ORIGIN) = { spherex           , spherey           , spherez           , meshSize_EQ };
  NP = newp;
  Point(NP)     = { spherex           , spherey           , spherez + spherer , meshSize_NP };
  SP = newp;
  Point(SP)     = { spherex           , spherey           , spherez - spherer , meshSize_SP };
  EQ0 = newp;
  Point(EQ0)    = { spherex + spherer , spherey           , spherez           , meshSize_EQ };
  EQ90 = newp;
  Point(EQ90)   = { spherex           , spherey + spherer , spherez           , meshSize_EQ };
  EQ180 = newp;
  Point(EQ180)  = { spherex - spherer , spherey           , spherez           , meshSize_EQ };
  EQ270 = newp;
  Point(EQ270)  = { spherex           , spherey - spherer , spherez           , meshSize_EQ };

  ARC_EQ1 = newl;
  Circle(ARC_EQ1)   = { EQ0   , ORIGIN , EQ90  };
  ARC_EQ2 = newl;
  Circle(ARC_EQ2)   = { EQ90  , ORIGIN , EQ180 };
  ARC_EQ3 = newl;  
  Circle(ARC_EQ3)   = { EQ180 , ORIGIN , EQ270 };
  ARC_EQ4 = newl;
  Circle(ARC_EQ4)   = { EQ270 , ORIGIN , EQ0   };
  ARC_NP0 = newl;
  Circle(ARC_NP0)   = { NP    , ORIGIN , EQ0   };
  ARC_NP90 = newl;
  Circle(ARC_NP90)  = { EQ90  , ORIGIN , NP    };
  ARC_NP180 = newl;
  Circle(ARC_NP180) = { EQ180 , ORIGIN , NP    };
  ARC_NP270 = newl;
  Circle(ARC_NP270) = { NP    , ORIGIN , EQ270 };
  ARC_SP0 = newl;
  Circle(ARC_SP0)   = { EQ0   , ORIGIN , SP    };
  ARC_SP90 = newl;
  Circle(ARC_SP90)  = { SP    , ORIGIN , EQ90  };
  ARC_SP180 = newl;
  Circle(ARC_SP180) = { SP    , ORIGIN , EQ180 };
  ARC_SP270 = newl;
  Circle(ARC_SP270) = { EQ270 , ORIGIN , SP    };

  LL_NPEQ1 = newll;
  Line Loop(LL_NPEQ1) = { ARC_NP90 , ARC_NP0 , ARC_EQ1 };
  RS_NPEQ1 = news;
  Ruled Surface(RS_NPEQ1) = { -LL_NPEQ1 };
  LL_NPEQ2 = newll;
  Line Loop(LL_NPEQ2) = { ARC_NP180 , ARC_EQ2 , -ARC_NP90 };
  RS_NPEQ2 = news;
  Ruled Surface(RS_NPEQ2) = { -LL_NPEQ2 };
  LL_NPEQ3 = newll;
  Line Loop(LL_NPEQ3) = { ARC_EQ3 , -ARC_NP180 , -ARC_NP270 };
  RS_NPEQ3 = news;
  Ruled Surface(RS_NPEQ3) = { -LL_NPEQ3 };
  LL_NPEQ4 = newll;
  Line Loop(LL_NPEQ4) = { ARC_EQ4 , -ARC_NP0 , ARC_NP270 };
  RS_NPEQ4 = news;
  Ruled Surface(RS_NPEQ4) = { -LL_NPEQ4 };
  LL_SPEQ1 = newll;
  Line Loop(LL_SPEQ1) = { ARC_SP90 , ARC_SP0 , -ARC_EQ1 };
  RS_SPEQ1 = news;
  Ruled Surface(RS_SPEQ1) = { -LL_SPEQ1 };
  LL_SPEQ2 = newll;
  Line Loop(LL_SPEQ2) = { -ARC_EQ2 , -ARC_SP90 , ARC_SP180 };
  RS_SPEQ2 = news;
  Ruled Surface(RS_SPEQ2) = { -LL_SPEQ2 };
  LL_SPEQ3 = newll;
  Line Loop(LL_SPEQ3) = { -ARC_SP180 , -ARC_EQ3 , -ARC_SP270 };
  RS_SPEQ3 = news;
  Ruled Surface(RS_SPEQ3) = { -LL_SPEQ3 };
  LL_SPEQ4 = newll;
  Line Loop(LL_SPEQ4) = { ARC_SP270 , -ARC_EQ4 , -ARC_SP0 };
  RS_SPEQ4 = news;
  Ruled Surface(RS_SPEQ4) = { -LL_SPEQ4 };

  SSPHERE[] = { RS_NPEQ1 , RS_NPEQ2 , RS_NPEQ3 , RS_NPEQ4 , RS_SPEQ1 , RS_SPEQ2 , RS_SPEQ3 , RS_SPEQ4 };
 
Return
