# EDM Canonical Test Cases: To-Do List

* Add exporting of w/wr/J/Jr at subset of time-steps to
  time domain soltion.

* Add 3D surface plot to Octave and gnuplot postprocessing.

* Determine domain volumes and surface areas from the mesh 
  so get more accurate PWB calculation when mesh density is low.
  
  Do before in mesh2D/mesh3D?
  Move derived parameters only used for PWB into PWB.
  Rename derivedParameters into SEAParameters?
  
  3D single cavity:

  cavityVolume = int3d(Th) ( 1.0 );
  wallArea = int2d(Th,Gwall) ( 1.0 );
  partArea = int2d(Th,Gpart) ( 1.0 );
  cylArea = int2d(Th,Gcyl) ( 1.0 );
  srcArea = int2d(Th,Gsrc) ( 1.0 );
  cavityArea = wallArea + partArea + cylArea + srcArea;
 
  3D dual cavity SDM:

  bothCavityVolume = int3d(Th) ( 1.0 );
  
  wallArea1 = int2d(Th,Gwall1) ( 1.0 );
  wallArea2 = int2d(Th,Gwall2) ( 1.0 );
  partArea1 = int2d(Th,Gpart1) ( 1.0 );
  partArea2 = int2d(Th,Gpart2) ( 1.0 );
  cylArea = int2d(Th,Gcyl) ( 1.0 );
  srcArea = int2d(Th,Gsrc) ( 1.0 );
  cavityArea1 = wallArea1 + partArea1 + holeArea + srcArea;
  cavityArea2 = wallArea2 + partArea2 + holeArea + cylArea;
  
  srcVolume = 4 / 3 * pi * srcRadius^3;
  cavityVolume1 = ( Lx - partX ) * Ly * Lz + 0.5 * partThickness * holeWidth * Lz - srcVolume;
  cavityVolume2 = bothCavityVolume - cavityVolume1;
    
  3D dual cavity DDM:

  cavityVolume1 = int3d(Th1) ( 1.0 );
  cavityVolume2 = int3d(Th2) ( 1.0 );
  wallArea1 = int2d(Th,Gwall1) ( 1.0 );
  wallArea2 = int2d(Th,Gwall2) ( 1.0 );
  partArea1 = int2d(Th,Gpart1) ( 1.0 );
  partArea2 = int2d(Th,Gpart2) ( 1.0 );
  holeArea1 = int2d(Th,Ghole1) ( 1.0 );
  holeArea2 = int2d(Th,Ghole2) ( 1.0 ); 
  cylArea = int2d(Th,Gcyl) ( 1.0 );
  srcArea = int2d(Th,Gsrc) ( 1.0 );
  cavityArea1 = wallArea1 + partArea1 + holeArea1 + srcArea;
  cavityArea2 = wallArea2 + partArea2 + holeArea2 + cylArea;
  
  2D:

  cavityXSArea = int2d(Th) ( 1.0 );
  cavityVolume = Lz * cavityXSArea;
  wallPerimeter = int1d(Th,Gwall) ( 1.0 );
  wallArea =  Lz * wallPerimeter;

* Add volume source capability.

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
  
