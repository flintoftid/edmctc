![](https://bitbucket.org/uoyaeg/aeg/wiki/edmctc.jpg )

# Canonical test cases for electromagnetic diffusion models

This suite of software and models provides a set of canonical test cases for
electromagnetic diffusion models of the average energy density in highly 
reverberant environments in which the field is diffuse. It was developed in
the [Department of Electronics][] at the [University of York][] for research 
in electromagnetic compatibility ([EMC][]) applications.

## The electromagnetic diffusion model

**TBC** Short introduction to EDM ([Flintoft2017][]) with reference to acoustic literature and 
PWB method. Link to [AEGPWB][].

## Test case features

The test cases include:

* Absorption in cavity walls;

* Absorption in  a volumetric lossy object.

* Transmission through electrically small and large apertures.

* Excitation by point and surface sources.

* Sabine and Jing and Xiang absorption models.

## Requirements

The test-cases are implemented using a combination of [Open Source][] tools:

1. [Gmsh][]: To create the meshes for the 3D models [Gmsh][] must be installed. A
   recent version is recommended ([Hecht2012][]).

2. [FreeFEM++][]: The solutions are implemented using the Finite Element Method [FEM][]
   with the [FreeFEM++][] package ([Geuzaine2009][]).

3. [GNU][] [Octave][] or [MATLAB][]: Most of the post-processing is implemented in a portable 
   subset of GNU [Octave][] / [MATLAB][]. 
   
The test cases have been primarily developed using GNU [Octave][] on Linux platforms, 
but should run under both GNU [Octave][] and [MATLAB][] on Linux and Windows systems.

## Documentation

This is it so far...

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

* Interesting examples that can be used for test-cases.

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


[Dr Ian Flintoft]: https://idflintoft.bitbucket.io
[University of York]: http://www.york.ac.uk
[Department of Electronics]: http://www.elec.york.ac.uk
[Open Source]: http://opensource.org
[GPL3]: http://www.gnu.org/copyleft/gpl.html
[GNU]: https://www.gnu.org/home.en.html
[EMC]: http://www.york.ac.uk/electronics/research/physlayer/appliedem/emc/

[Install.md]: https://bitbucket.org/uoyaeg/edmctc/src/tip/Install.md
[tutorial]: https://bitbucket.org/uoyaeg/edmctc/src/tip/tutorial/Tutorial.md
[Bugs.md]: https://bitbucket.org/uoyaeg/edmctc/src/tip/doc/Bugs.md
[ToDo.md]: https://bitbucket.org/uoyaeg/edmctc/src/tip/doc/ToDo.md
[Licence.txt]: https://bitbucket.org/uoyaeg/edmctc/src/tip/Licence.txt

[Gmsh]: http://gmsh.info
[FreeFEM++]: http://www.freefem.org
[Octave]: http://www.gnu.org/software/octave
[MATLAB]: http://www.mathworks.co.uk/products/matlab
[Mercurial]: https://www.mercurial-scm.org
[AEGPWB]: https://bitbucket.org/uoyaeg/aegpwb

