%
% 2D post-processing.
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

% Spurious direct energy density.
if( isPart )
  w2ds = srcTRP ./ ( 4.0 .* pi .* D .* sqrt( ( x2 - srcX ).^2 + ( y2 - srcY ).^2 ) ) .* ( x2 <= partX ) + 0.0 .* ( x2 > partX ); 
  %w2ds = -srcTRP ./ ( 2.0 .* pi .* D ) .* log( sqrt( ( x2 - srcX ).^2 + ( y2 - srcY ).^2 ) ) .* ( x2 <= partX ) + 0.0 .* ( x2 > partX ); 
else
  w2ds = srcTRP ./ ( 4.0 .* pi .* D .* sqrt( ( x2 - srcX ).^2 + ( y2 - srcY ).^2 ) );
  %w2ds = -srcTRP ./ ( 2.0 .* pi .* D ) .* log( sqrt( ( x2 - srcX ).^2 + ( y2 - srcY ).^2 ) );
end % if

% Reverberant energy density.
w2r = w2 - w2ds;
w2r( find( w2r < 0.0 ) ) = NaN;

% Direct energy density flux.
denom = ( ( x2 - srcX ).^2 + ( y2 - srcY ).^2 ).^(3/2);
J2dx = srcTRP ./ 4.0 ./ pi .* ( x2 - srcX ) ./ denom;
J2dy = srcTRP ./ 4.0 ./ pi .* ( y2 - srcY ) ./ denom;
J2dmag = sqrt( J2dx.^2 + J2dy.^2 );

% Diffuse energy density flux.
%[ J2rx , J2ry ] = gradient( w2r , x2(2,1) - x2(1,1) , y2(1,2) - y2(1,1) );
%J2rx = -D .* J2rx;
%J2ry = -D .* J2ry;
J2rx = J2x - J2dx;
J2ry = J2y - J2dy;
J2rmag = sqrt( J2rx.^2 + J2ry.^2 );

% Scalar power density.
S2 = c0 .* w2;
S2r = c0 .* w2r;

% Uniformity relative to PWB model.
if( isPart )
  Delta2 = w2r ./ ( w1pwb .* ( x2 < partX ) + w2pwb .* ( x2 >= partX ) );
else
  Delta2 = w2r ./ w0pwb;
end % if

% Magnitude of energy density flux.
J2mag = sqrt( J2x.^2 + J2y.^2 );

% Annisotropy.
Upsilon2 = S2 ./ ( S2 - J2mag );
Upsilon2( find( Upsilon2 <= 0.0 ) ) = NaN;

% Decibels values for plots.
S2dB = 10.0 .* log10( S2 );
S2rdB = 10.0 .* log10( S2r );
Delta2dB = 10.0 .* log10( Delta2 );
J2dB = 10.0 .* log10( J2mag );
Upsilon2dB = 10.0 .* log10( Upsilon2 );

% Report statistics.
fp = fopen( 'postprocess2D.dat' , 'w' );
if( isPart )

  idx1 = find( ( x2(:) <= partX ) & ~isnan( S2r(:) ) );
  idxObsX1 = find( xx >= obsX1 , 1 );
  idxObsY1 = find( yy >= obsY1 , 1 );
  obsSr1 = S2r(idxObsX1,idxObsY1);  
  meanSr1 = nanmean( S2r(idx1) );
  minSr1 = nanmin( S2r(idx1) );
  maxSr1 = nanmax( S2r(idx1) );   
  stdSr1 = nanstd( S2r(idx1) );
  covSr1 = stdSr1 ./ meanSr1;
  
  idx2 = find( ( x2(:) > partX ) & ~isnan( S2r(:) ) );
  idxObsX2 = find( xx >= obsX2 , 1 );
  idxObsY2 = find( yy >= obsY2 , 1 );
  obsSr2 = S2r(idxObsX2,idxObsY2);  
  meanSr2 = nanmean( S2r(idx2) );
  minSr2 = nanmin( S2r(idx2) );
  maxSr2 = nanmax( S2r(idx2) );   
  stdSr2 = nanstd( S2r(idx2) );
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
  obsSr0 = S2r(idxObsX0,idxObsY0);  
  meanSr0 = nanmean( S2r );
  minSr0 = nanmin( S2r );
  maxSr0 = nanmax( S2r );   
  stdSr0 = nanstd( S2r );
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
