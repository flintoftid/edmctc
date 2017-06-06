%
% 3D post-processing.
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

% Direct energy density.
if( isPart )
  wd = srcTRP ./ ( 4.0 .* pi .* D .* sqrt( ( x - srcX ).^2 + ( y - srcY ).^2 + ( z - srcZ ).^2 ) ) .* ( x <= partX ) + 0.0 .* ( x > partX ); 
else
  wd = srcTRP ./ ( 4.0 .* pi .* D .* sqrt( ( x - srcX ).^2 + ( y - srcY ).^2 + ( z - srcZ ).^2 ) );
end % if

% Diffuse energy density.
wr = w - wd;
wr( find( wr < 0.0 ) ) = NaN;

% Direct energy density flux.
denom = ( ( x - srcX ).^2 + ( y - srcY ).^2 + ( z - srcZ ).^2 ).^(3/2);
Jdx = srcTRP ./ 4.0 ./ pi .* ( x - srcX ) ./ denom;
Jdy = srcTRP ./ 4.0 ./ pi .* ( y - srcY ) ./ denom;
Jdz = srcTRP ./ 4.0 ./ pi .* ( z - srcZ ) ./ denom;
Jdmag = sqrt( Jdx.^2 + Jdy.^2 + Jdz.^2 );

% Diffuse energy density flux.
%[ Jrx , Jry , Jrz ] = gradient( wr , x(2,1,1) - x(1,1,1) , y(1,2,1) - y(1,1,1) , z(1,1,2) - z(1,1,1) );
%Jrx = -D .* Jrx;
%Jry = -D .* Jry;
%Jrz = -D .* Jrz;
Jrx = Jx - Jdx;
Jry = Jy - Jdy;
Jrz = Jz - Jdz;
Jrmag = sqrt( Jrx.^2 + Jry.^2 + Jrz.^2 );

%w = wr;
%Jx = Jrx;
%Jy = Jry;
%Jz = Jrz;

% Scalar power density.
S = c0 .* w;
Sr = c0 .* wr;

% Uniformity relative to PWB model.
if( isPart )
  Delta = wr ./ ( w1pwb .* ( x < partX ) + w2pwb .* ( x >= partX ) );
else
  Delta = wr ./ w0pwb;
end % if

% Magnitude of energy density flux.
Jmag = sqrt( Jx.^2 + Jy.^2 + Jz.^2 );

% Annisotropy.
Upsilon = S ./ ( S - Jmag );
Upsilon( find( Upsilon <= 0.0 ) ) = NaN;

% Decibels values for plots.
SdB = 10.0 .* log10( S );
SrdB = 10.0 .* log10( Sr );
DeltadB = 10.0 .* log10( Delta );
JdB = 10.0 .* log10( Jmag );
UpsilondB = 10.0 .* log10( Upsilon );

% Volume average reverberant power densities.
if( isPart )
  ic1 = floor( partX / Lx / 2 * Nx );
  ic2 = floor( Nx - ( Lx - partX ) / Lx / 2 * Nx );
  jc = floor( Ny / 2 );
  kc = floor( Nz / 2 );
  fprintf( 'EDM power density at centre of sub-cavity 1: %g W/m^2 = %g dB W/m^2\n' , S(ic1,jc,kc) , db10( S(ic1,jc,kc) ) );
  fprintf( 'EDM power density at centre of sub-cavity 2: %g W/m^2 = %g dB W/m^2\n' , S(ic2,jc,kc) , db10( S(ic2,jc,kc) ) ); 
  idx1 = find( ( x(:) < partX ) & ~isnan( Sr(:) ) );
  idx2 = find( ( x(:) > partX ) & ~isnan( Sr(:) ) );
  fprintf( 'Average EDM power density in sub-cavity 1: %g W/m^2 = %g dB W/m^2\n'  , nanmean( S(idx1) ) , db10( nanmean( S(idx1) ) ) );
  fprintf( 'Average EDM power density in sub-cavity 2: %g W/m^2 = %g dB W/m^2\n'  , nanmean( S(idx2) ) , db10( nanmean( S(idx1) ) ) );
  fprintf( 'Average EDM reverberant power density in sub-cavity 1: %g W/m^2 = %g dB W/m^2\n'  , nanmean( Sr(idx1) ) , db10( nanmean( Sr(idx1) ) ) );
  fprintf( 'Average EDM reverberant power density in sub-cavity 2: %g W/m^2 = %g dB W/m^2\n'  , nanmean( Sr(idx2) ) , db10( nanmean( Sr(idx1) ) ) );
else
  ic = floor( Nx / 2 );
  jc = floor( Ny / 2 );
   kc = floor( Nz / 2 ); 
  fprintf( 'EDM power density at centre of cavity: %g W/m^2 = %g dB W/m^2\n' , S(ic,jc,kc) , db10( S(ic,jc,kc) ) ); 
  idx = find( ~isnan( Sr(:) ) );
  fprintf( 'Average EDM power density: %g W/m^2 = %g dB W/m^2\n' , nanmean( S(idx) ) , db10( nanmean( S(idx) ) ) );
  fprintf( 'Average EDM reverberant power density: %g W/m^2 = %g dB W/m^2\n' , nanmean( Sr(idx) ) , db10( nanmean( Sr(idx) ) ) ); 
end % if
