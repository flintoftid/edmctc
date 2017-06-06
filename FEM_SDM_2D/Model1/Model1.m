%
% 2D single domain model of the Canonical Test Cases.
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

[ x2 , y2 , w2 ] = ffImportEnergyDensity2D( 'w.dat' );
xx = squeeze( x2(:,1) );
yy = squeeze( y2(1,:) );
Nx = length( xx );
Ny = length( yy );

[ x2J , y2J , J2x , J2y ] = ffImportEnergyDensityFlux2D( 'J.dat' );

%
% Kantorovich unreduction.
%

Kantorovich;

% 3D coordinates.
Nz = 50;

xxx(:,1,1) = xx;
x = repmat( xxx , [ 1 , Ny , Nz ] );

yyy(1,:,1) = yy;
y = repmat( yyy , [ Nx , 1 , Nz ] );

zz = linspace( 0 , Lz , Nz );
zzz(1,1,:) = zz;
z = repmat( zzz , [ Nx , Ny , 1 ] );

% Energy density and flux at floor level. FreeFEM model outputs 
% values at half-height of cavity.
w20 =  w2  ./ ZHalfHeight1 .* ( x <= partX ) +  w2 ./ ZHalfHeight2 .* ( x > partX );
J2x0 = J2x ./ ZHalfHeight1 .* ( x <= partX ) + J2x ./ ZHalfHeight2 .* ( x > partX );
J2y0 = J2y ./ ZHalfHeight1 .* ( x <= partX ) + J2y ./ ZHalfHeight2 .* ( x > partX );

% Vertical profile and gradient.
zeta_z = wallEC / D1 .* ( x <= partX ) + wallEC / D2 .* ( x > partX );
Z = 1 + zeta_z .* ( z - z.^2 ./ Lz );
dZdz = zeta_z .* ( 1 - 2.0 .* z ./ Lz );

% 3D energy density.
w = w20 .* Z;

% Inhomogeneous diffusivity.
D = D1 .* ( x2 <= partX ) + D2 .* ( x2 > partX );

% 3D energy density flux.
Jx = J2x0 .* Z;
Jy = J2y0 .* Z;
Jz = -( D1 .* ( x <= partX ) + D2 .* ( x > partX ) ) .* w20 .* dZdz;

% Post-processing.
postprocess2D;
%postprocess3D;

% Plots
plot2D;
%plot3D;

