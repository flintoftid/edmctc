%
% 3D single domain model of the Canonical Test Cases.
%
% (c) 2016-2017, Ian D. Flintoft <ian.flintoft@googlemail.com>
%
% This file is part of the Electromagnetic Diffusion Model (EDM) 
% Canonical Example Suite [Flintoft2017,flintoft2017b].
%
% The EDM Canonical Example Suite is free software: you can 
% redistribute it and/or modify it under the terms of the GNU 
% General Public License as published by the Free Software 
% Foundation, either version 3 of the License, or (at your option) 
% any later version.
%
% The EDM Canonical Example Suite is distributed in the hope that 
% it will be useful, but WITHOUT ANY WARRANTY; without even the 
% implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
% PURPOSE.  See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with  The EDM Canonical Example Suite.  If not, 
% see <http://www.gnu.org/licenses/>.
%
% References:
%
% [Flintoft2017] I D Flintoft, A C Marvin, F I Funn, L Dawson, X Zhang,
% M P Robinson, and J F Dawson, "Evaluation of the diffusion equation for
% modelling reverberant electromagnetic fields", IEEE Transactions on Electromagnetic
% Compatibility, vol. 59, no. 3, pp. 760–769, 2017. DOI: 10.1109/TEMC.2016.2623356.
%
% [Flintoft2017b] I D Flintoft and J F Dawson, “3D electromagnetic diffusion models 
% for reverberant environments”, 2017 International Conference on Electromagnetics 
% in Advanced Applications (ICEAA2017), Verona, Italy, pp. 11-15 Sep. 2017.
%

addpath( '../../m' );

% Macros.
macros;

% Physical constants.
generalParameters;

% Model input parameters.
inputParameters;

% Derived parameters.
derivedParameters;

% SEA parameters.
SEA;

% PWB model.
PWB;

%
% Load FEM solution.
% 

[ x , y , z , w ] = ffImportEnergyDensity3D( 'w.dat' );
xx = squeeze( x(:,1,1) );
yy = squeeze( y(1,:,1) );
zz = squeeze( z(1,1,:) );
Nx = length( xx );
Ny = length( yy );
Nz = length( zz );

[ xJ , yJ , zJ , Jx , Jy , Jz ] = ffImportEnergyDensityFlux3D( 'J.dat' );

if( isPart )
  ic1 = floor( partX / Lx / 2 * Nx );
  ic2 = floor( Nx - ( Lx - partX ) / Lx / 2 * Nx );
  jc = floor( Ny / 2 );
  kc = floor( Nz / 2 );
  fprintf( 'EDM power density at centre of sub-cavity 1: %g W/m^2 = %g dB W/m^2\n' , c0 * w(ic1,jc,kc) , db10( c0 * w(ic1,jc,kc) ) );
  fprintf( 'EDM power density at centre of sub-cavity 2: %g W/m^2 = %g dB W/m^2\n' , c0 * w(ic2,jc,kc) , db10( c0 * w(ic2,jc,kc) ) ); 
else
  ic = floor( Nx / 2 );
  jc = floor( Ny / 2 );
  kc = floor( Nz / 2 );
  fprintf( 'EDM power density at centre of cavity: %g W/m^2 = %g dB W/m^2\n' , c0 .* w(ic,jc,kc) , db10( c0 .* w(ic,jc,kc) ) ); 
end % if

%
% Kantorovich reduction.
%

% Vertical profile and gradient.
zeta_z = wallEC / D1 .* ( x <= partX ) + wallEC / D2 .* ( x > partX );
Z = 1 + zeta_z .* ( z - z.^2 ./ Lz );
dZdz = zeta_z .* ( 1 - 2.0 .* z ./ Lz );

% Inhomogeneous diffusivity.
D = D1 .* ( x <= partX ) + D2 .* ( x > partX );

% Post-processing.
postprocess3D;

% Plots
plot3D_oct;

