![](https://bitbucket.org/uoyaeg/edmctc/wiki/edmctc.jpg )

# Canonical test cases for electromagnetic diffusion models

This suite of software and models provides a set of canonical test cases for
electromagnetic diffusion models of the average energy density in highly 
reverberant environments in which the field is diffuse. It was developed in
the [Department of Electronics][] at the [University of York][] for research 
in electromagnetic compatibility ([EMC][]) applications.

## The electromagnetic diffusion model

The power balance (PWB) method of estimating the average diffuse field in a system of 
coupled cavities, as implemented in [AEGPWB][], assumes that the energy density in each
cavity is uniform ([Hill1994][],[Junqua2005][]). It therefore cannot account for the 
inhomogeneity in the diffuse field arising from any loss in the cavity. The electromagnetic
diffusion model (EDM), another statistical energy analysis (SEA) method, was proposed as 
a natural generalization of the PWB method that is able to predict such inhomogeneity 
([Flintoft2017][]). The EDM is a straightforward translation of the acoustic diffusion 
model (ADM) into the electromagnetic domain ([Navarro2015][],[Savioja2015][]); the 
differences between the EDM and ADM are essentially confined to the auxiliary calculations 
of the absorption and transmission efficiencies of surface and apertures respectively. 
However, the validity and accuracy of the EDM must still be established independently of 
the ADM since the realms of application are significantly different and the 
electromagnetic field is polarized. A suite of canonical test cases was therefore 
created into order to explore the realm of validity of the EDM.

Preliminary results for the canonical test cases obtained using two-dimensional models 
were reported in ([Flintoft2017][]). Initial three-dimensional models will be presented 
in ([Flintoft2017b][]).

## Test case features

The test cases include:

* Absorption in cavity walls;

* Absorption in volumetric lossy objects.

* Transmission through electrically small and large apertures.

* Excitation by point and surface sources.

* Sabine ([Sabine1922][]) and Jing and Xiang ([Jing2008][]) exchange coefficient
  absorption models.

## Requirements

The test-cases are implemented using a combination of [Open Source][] tools:

1. [Gmsh][]: To create the meshes for the 3D models [Gmsh][] must be installed. A
   recent version is recommended ([Hecht2012][]).

2. [FreeFEM++][]: The solutions are implemented using the Finite Element Method [FEM][]
   with the [FreeFEM++][] package ([Geuzaine2009][]).

3. [GNU][] [Octave][] or [MATLAB][]: Most of the post-processing is implemented in 
   a portable subset of [GNU][] [Octave][] / [MATLAB][]. Version 4.0 of [Octave][] or above
   is required. 

4. [cquiver][]: Vector field plots in [Octave][] / [MATLAB][] require the cquiver function.
   
The test cases have been primarily developed using GNU [Octave][] on Linux platforms, 
but should run under both [GNU][] [Octave][] and [MATLAB][] on Linux and Windows systems.

## Documentation

There are four implementations of the test cases:

1. [FEM_SDM_2D][]: An approximate two-dimensional solution using Kantorovich reduction. 
   The partitioned cavity is implemented using a single domain method (SDM). This implicitly
   enforces continuity of the energy density and its flux through the aperture.

2. [FEM_DDM_2D][]: An approximate two-dimensional solution using Kantorovich reduction
   of the partitioned cavity cases implemented using a coupled dual domain method (DDM) with
   an energy exchange boundary condition. This enforces continuity of the energy density
   flux through the aperture. An iterative method is used to find the solution.

3. [FEM_SDM_3D][]: A full three-dimensional solution. The partitioned cavity is 
   implemented using a single domain method (SDM).

4. [FEM_DDM_3D][]: A full three-dimensional solution of the partitioned cavity
   cases implemented using a coupled dual domain method (DDM).

There is a list and description of the main variables in doc/[Variables.md][].

The outline work-flow is

1. Set the input parameters in the `parameters.geo` file.

2. Create the mesh if required using Gmsh. This must be done interactively via
   the GUI. The mesh must be saved in the INRA Mesh format, choosing the export
   option "physical entities". The normal vectors for all surfaces enclosing a 
   cavity must be pointing outwards.

    $ Gmsh SDM_2D.geo

    Mesh -> 2D
    Mesh -> 3D
    Save As -> INRA Mesh -> physical entities -> model.mesh

3. Solve the problem using [FreeFEM++][]:

    $ FreeFem++ Model1.edp

   This should create ASCII data files `w.dat`, `wr.dat`, `J.dat` and `Jr.dat` 
   containing the energy density, reverberant energy density, energy density
   flux and reverberant energy density flux fields respectively.

4. Post-process the fields using GNU [Octave][] or [MATLAB][]:

    $ octave 
    octave> Model1

## Notes

* The plots are currently of limited quality with [Octave][] version 4.0.3.

* The [FreeFEM++][] and [Octave][] code is modular in the sense that it is split
  into different files; however, the name-space is global so care must be taken
  regarding variable name clashes.

* Beware the scoping rules in FreeFEM++. Certain entities are implemented as
  "macros" and cannot be declared and defined separately. This mean that 
  sometimes code has to be repeated in different blocks.

* The same `parameters.geo` is read by the Gmsh, FreeFEM++ and Octave scripts.

## Bugs and support

The test case implementation is still under development and no doubt will contain 
many bugs. Known significant bugs are listed in the file doc/[Bugs.md][] in the 
source code. 

Please report bugs using the bitbucket issue tracker at 
<https://bitbucket.org/uoyaeg/edmctc/issues> or by email to 
<ian.flintoft@googlemail.com>.

For general guidance on how to write a good bug report see, for example:

* <http://www.chiark.greenend.org.uk/~sgtatham/bugs.html>
* <http://noverse.com/blog/2012/06/how-to-write-a-good-bug-report>
* <http://www.softwaretestinghelp.com/how-to-write-good-bug-report>

Some of the tips in <http://www.catb.org/esr/faqs/smart-questions.html> are also 
relevant to reporting bugs.

There is a Wiki on the bitbucket [project page](https://bitbucket.org/uoyaeg/edmctc/wiki/). 

## How to contribute

We welcome any contributions to the development of the code, including:

* Fixing bugs.

* Improving the user documentation.

* Items in the to-do list in the file doc/[ToDo.md][].

Please contact [Dr Ian Flintoft], <ian.flintoft@googlemail.com>, if you are 
interested in helping with these or any other aspect of development.

## Licence

The code is licensed under the GNU Public Licence, version 3 [GPL3][]. For 
details see the file [Licence.txt][].

## Developers

[Dr Ian Flintoft][], <ian.flintoft@googlemail.com>

## Contacts

[Dr Ian Flintoft][], <ian.flintoft@googlemail.com>

## References

[Flintoft2017]: http://dx.doi.org/10.1109/TEMC.2016.2623356

([Flintoft2017][]) I. D. Flintoft, A. C. Marvin, F. I. Funn, L. Dawson, X. Zhang,
M. P. Robinson and J. F. Dawson, "Evaluation of the diffusion equation for
modelling reverberant electromagnetic fields", IEEE Transactions on Electromagnetic
Compatibility, vol. 59, no. 3, pp. 760–769, 2017. 
[Postprint](https://pure.york.ac.uk/portal/files/50375003/TEMC_Flintoft_et_al_postprint.pdf)

[Flintoft2017b]: http://www.iceaa.net/j3

([Flintoft2017b][]) I. D. Flintoft and J. F. Dawson, “3D electromagnetic diffusion models 
for reverberant environments”, 2017 International Conference on Electromagnetics 
in Advanced Applications (ICEAA2017), Verona, Italy, pp. 11-15 Sep. 2017.

[Geuzaine2009]: http://dx.doi.org/10.1002/nme.2579

([Geuzaine2009][]) C. Geuzaine and J.-F. Remacle, "Gmsh: a three-dimensional finite element mesh 
generator with built-in pre- and post-processing facilities", International Journal for Numerical 
Methods in Engineering 79(11), pp. 1309-1331, 2009.

[Hecht2012]: http://dx.doi.org/10.1515/jnum-2012-0013

([Hecht2012][]) F. Hecht, “New development in FreeFEM++”, Journal of Numerical Mathematics, 
vol. 20, no. 3-4, pp. 251–265, 2012.

[Hill1994]: http://ieeexplore.ieee.org/xpl/articleDetails.jsp?tp=&arnumber=305461

([Hill1994]) D. A. Hill, M. T. Ma, A. R. Ondrejka, B. F. Riddle, M. L. Crawford 
and R. T. Johnk, "Aperture excitation of electrically large, lossy cavities", 
IEEE Transactions on Electromagnetic Compatibility, vol. 36, no. 3, pp. 169-178, 
Aug 1994.

[Jing2008]: https://doi.org/10.1121/1.3008066

([Jing2008][]) Y. Jing and N. Xiang, “Visualizations of sound energy across coupled 
rooms using a diffusion equation model”, J. Acoust. Soc. Am., vol. 124, pp. EL360–EL365, Nov. 2008.

[Junqua2005]: http://www.tandfonline.com/doi/abs/10.1080/02726340500214845

([Junqua2005]) I. Junqua, J.-P. Parmantier and F. Issac,
"A Network Formulation of the Power Balance Method for High-Frequency Coupling",
Electromagnetics, vol. 25 , no. 7-8, pp. 603-622, 2005.

[Navarro2015]: http://dx.doi.org/10.1080/19401493.2013.850534

([Navarro2015][]) J. M. Navarro and J. Escolano, “Simulation of building indoor acoustics 
using an acoustic diffusion equation model”, Journal of Building Performance Simulation, 
vol. 8, no. 1, pp. 3-14, 2015.

[Sabine1922]: https://archive.org/details/collectedpaperso00sabi

([Sabine1922][]) W. C. Sabine, Collected Papers on Acoustics, Harvard University Press, 1922

[Savioja2015]: http://dx.doi.org/10.1121/1.4926438

([Savioja2015][]) L. Savioja and U. Peter Svensson, “Overview of geometrical room acoustic 
modeling techniques”, J. Acoust. Soc. Am., vol. 138, no .2, pp. 708–730, 2015.

[Dr Ian Flintoft]: https://idflintoft.bitbucket.io
[University of York]: http://www.york.ac.uk
[Department of Electronics]: http://www.elec.york.ac.uk
[Open Source]: http://opensource.org
[GNU]: http://www.gnu.org
[GPL3]: http://www.gnu.org/copyleft/gpl.html
[GNU]: https://www.gnu.org/home.en.html
[EMC]: http://www.york.ac.uk/electronics/research/physlayer/appliedem/emc/
[FEM]: https://en.wikipedia.org/wiki/Finite_element_method

[Install.md]: https://bitbucket.org/uoyaeg/edmctc/src/tip/Install.md
[tutorial]: https://bitbucket.org/uoyaeg/edmctc/src/tip/tutorial/Tutorial.md
[Bugs.md]: https://bitbucket.org/uoyaeg/edmctc/src/tip/doc/Bugs.md
[ToDo.md]: https://bitbucket.org/uoyaeg/edmctc/src/tip/doc/ToDo.md
[Variables.md]: https://bitbucket.org/uoyaeg/edmctc/src/tip/doc/Variables.md
[Licence.txt]: https://bitbucket.org/uoyaeg/edmctc/src/tip/Licence.txt
[FEM_SDM_2D]: https://bitbucket.org/uoyaeg/edmctc/src/tip/FEM_SDM_2D
[FEM_DDM_2D]: https://bitbucket.org/uoyaeg/edmctc/src/tip/FEM_DDM_2D
[FEM_SDM_3D]: https://bitbucket.org/uoyaeg/edmctc/src/tip/FEM_SDM_3D
[FEM_DDM_3D]: https://bitbucket.org/uoyaeg/edmctc/src/tip/FEM_DDM_3D

[Gmsh]: http://gmsh.info
[FreeFEM++]: http://www.freefem.org
[Octave]: http://www.gnu.org/software/octave
[MATLAB]: http://www.mathworks.co.uk/products/matlab
[Mercurial]: https://www.mercurial-scm.org
[AEGPWB]: https://bitbucket.org/uoyaeg/aegpwb
[cquiver]: http://uk.mathworks.com/matlabcentral/fileexchange/29487-2d-vector-field-visualization

