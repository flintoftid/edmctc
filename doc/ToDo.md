# EDM Canonical Test Cases: To-Do List

* Verfiy the 2D spurious direct solution - need to find good reference
  for the 2D time-independent Green's function of the Poisson equation.

* Document implementation of the iterative solution for coupled domains.

* Convert implementation notes to LaTeX and add to repo.  

* Rename Kantorovich parameters

  zetaz1    vertLossRate1
  Z11       intZ1
  Z21       intZSquared1
  Zho21     ZHalfHeight1
  d2Zdz21   int2ndDerivZ1
  LambdaZ1  arealLossRate1
  Dp1       redD1
  wallECp1  redWallEC1
  partECp1  redPartEC1

  and similar for sub-cavity 2.

  cylECp2   redCylEC2
  holeEC11p redHoleEC11
  holeEC12p redHoleEC12
  holeEC21p redHoleEC21
  holeEC22p redHoleEC22

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

