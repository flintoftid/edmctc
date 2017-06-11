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

% Report statistics.
fp = fopen( 'postprocess3D.dat' , 'w' );
if( isPart )    

  idx1 = find( ( x(:) <= partX ) & ~isnan( Sr(:) ) );
  idxObsX1 = find( xx >= obsX1 , 1 );
  idxObsY1 = find( yy >= obsY1 , 1 );
  idxObsZ1 = find( zz >= obsZ1 , 1 );
  obsSr1 = Sr(idxObsX1,idxObsY1,idxObsZ1);  
  meanSr1 = nanmean( Sr(idx1) );
  minSr1 = nanmin( Sr(idx1) );
  maxSr1 = nanmax( Sr(idx1) );   
  stdSr1 = nanstd( Sr(idx1) );
  covSr1 = stdSr1 ./ meanSr1;
  
  idx2 = find( ( x(:) > partX ) & ~isnan( Sr(:) ) );
  idxObsX2 = find( xx >= obsX2 , 1 );
  idxObsY2 = find( yy >= obsY2 , 1 );
  idxObsZ2 = find( zz >= obsZ2 , 1 );
  obsSr2 = Sr(idxObsX2,idxObsY2,idxObsZ2);  
  meanSr2 = nanmean( Sr(idx2) );
  minSr2 = nanmin( Sr(idx2) );
  maxSr2 = nanmax( Sr(idx2) );   
  stdSr2 = nanstd( Sr(idx2) );
  covSr2 = stdSr2 ./ meanSr2;
  
  fprintf( fp , 'PWB power density in sub-cavity 1: %g W/m^2 = %g dB W/m^2\n' , S1pwb , db10( S1pwb ) );
  fprintf( fp , 'EDM power density at observation point of sub-cavity 1: %g W/m^2 = %g dB W/m^2\n' , obsSr1 , db10( obsSr1 ) );
  fprintf( fp , 'EDM mean power density in sub-cavity 1: %g W/m^2 = %g dB W/m^2\n' , meanSr1 , db10( meanSr1 ) );
  fprintf( fp , 'EDM minimum power density in sub-cavity 1: %g W/m^2 = %g dB W/m^2\n' , minSr1 , db10( minSr1 ) );
  fprintf( fp , 'EDM maximum power density in sub-cavity 1: %g W/m^2 = %g dB W/m^2\n' , maxSr1 , db10( maxSr1 ) );
  fprintf( fp , 'EDM standard deviation of power density in sub-cavity 1: %g W/m^2 = %g dB W/m^2\n' , stdSr1 , db10( stdSr1 ) );
  fprintf( fp , 'EDM coefficient of variation of power density in sub-cavity 1: %g = %g %%\n' , covSr1 , 100 * covSr1 );  
  fprintf( fp , 'PWB power density in sub-cavity 2: %g W/m^2 = %g dB W/m^2\n' , S2pwb , db10( S2pwb ) );
  fprintf( fp , 'EDM power density at observation point of sub-cavity 2: %g W/m^2 = %g dB W/m^2\n' , obsSr2 , db10( obsSr2 ) );
  fprintf( fp , 'EDM mean power density in sub-cavity 2: %g W/m^2 = %g dB W/m^2\n' , meanSr2 , db10( meanSr2 ) );
  fprintf( fp , 'EDM minimum power density in sub-cavity 2: %g W/m^2 = %g dB W/m^2\n' , minSr2 , db10( minSr2 ) );
  fprintf( fp , 'EDM maximum power density in sub-cavity 2: %g W/m^2 = %g dB W/m^2\n' , maxSr2 , db10( maxSr2 ) );  
  fprintf( fp , 'EDM standard deviation of power density in sub-cavity 2: %g W/m^2 = %g dB W/m^2\n' , stdSr2 , db10( stdSr2 ) );
  fprintf( fp , 'EDM coefficient of variation of power density in sub-cavity 2: %g = %g %%\n' , covSr2 , 100 * covSr2 );  
  
else

  idxObsX0 = find( xx >= obsX0 , 1 );
  idxObsY0 = find( yy >= obsY0 , 1 );
  idxObsZ0 = find( zz >= obsZ0 , 1 );
  obsSr0 = Sr(idxObsX0,idxObsY0,idxObsZ0);  
  meanSr0 = nanmean( Sr );
  minSr0 = nanmin( Sr );
  maxSr0 = nanmax( Sr );   
  stdSr0 = nanstd( Sr );
  covSr0 = stdSr0 ./ meanSr0;
  
  fprintf( fp , 'PWB power density in cavity: %g W/m^2 = %g dB W/m^2\n' , S0pwb , db10( S0pwb ) );
  fprintf( fp , 'EDM power density at observation point of cavity 2: %g W/m^2 = %g dB W/m^2\n' , obsSr0 , db10( obsSr0 ) );
  fprintf( fp , 'EDM mean power density in cavity: %g W/m^2 = %g dB W/m^2\n' , meanSr0 , db10( meanSr0 ) );
  fprintf( fp , 'EDM minimum power density in cavity: %g W/m^2 = %g dB W/m^2\n' , minSr0 , db10( minSr0 ) );
  fprintf( fp , 'EDM maximum power density in cavity: %g W/m^2 = %g dB W/m^2\n' , maxSr0 , db10( maxSr0 ) );  
  fprintf( fp , 'EDM standard deviation of power density in cavity: %g W/m^2 = %g dB W/m^2\n' , stdSr0 , db10( stdSr0 ) );
  fprintf( fp , 'EDM coefficient of variation of power density in cavity: %g = %g %%\n' , covSr0 , 100 * covSr0 );  
  
end % if
fclose( fp );
