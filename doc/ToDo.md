# EDM Canonical Test Cases: To-Do List

* Verfiy the 2D spurious direct solution - need to find good reference
  for the 2D time-independent Green's function of the Poisson equation.
  The 2D Green's function is 
  
    -1 / ( 2 * pi * D ) * log(|r-r0|)
  
  rather than the 3D Green's function 
  
    1 / ( 4 * pi * D * | r - r0 | )

* Especially is the calculation and subtraction of the direct energy 
  density correct in high loss cases. Since EDM isn't really valid 
  in this then maybe it is not an issue.

* Determine volumes and surface areas from mesh 
  so get more accurate PWB calculation when mesh
  density is low.

  Do before PWB calculation?
 
  3D:

  cavityVolume = int3d(Th) ( 1.0 );
  partArea = int2d(Th,Gpart) ( 1.0 );
  cylArea = int2d(Th,Gcyl) ( 1.0 );
  srcArea = int2d(Th,Gsrc) ( 1.0 );

  2D:

  cavityXSArea = int2d(Th) ( 1.0 );
  cavityVolume = Lz * cavityXSArea;
  wallPerimeter = int1d(Th,Gwall) ( 1.0 );
  wallArea =  Lz * wallPerimeter;

* Add Biot Number calculation

  wallBN = wallEC * MFP / D
  cylBN = cylEC * MFP / D

  Use total MFP and D or the ones for wall/cyl?

  Average ECs?
  
  BN = avgEC / D * MFP
  
  avgEC = surface area weighed average of boundary ECs.
  D = overall diffusivity.
  MFP = overall MFP.
  
  BN < 0.1 => EDM accurate.
