function gnpVectorMap( x , y, Vx , Vy , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , tag )
%gnpVectorMap - plot "velocity" of 2D vector field using gnuplot.
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

  baseName = fileparts( which( mfilename ) );
  pngFileName = [ tag , '.png' ];
  gnpFileName = [ tag , '.gnp' ];
  datFileName = [ tag , '.dat' ];
  styleFileName = [ baseName , '/edmcolormap.pal' ];

  Nx = size( x , 1 );
  Ny = size( y , 2 );
   
  Lx = x(end,1) - x(1,1);
  Ly = y(1,end) - y(1,1);
  L = min( [ Lx , Ly ] );
  dl = L / 12;
  stepX = floor( Nx / ( Lx / dl ) );
  stepY = floor( Ny / ( Ly / dl ) );

  Vmag = sqrt( Vx.^2 + Vy.^2 );
  Varg = atan2( Vy , Vx );
  
  dlmwrite( datFileName , [ x(1,:)' , y(1,:)' , Vmag(1,:)' , Varg(1,:)' ] , 'delimiter' , ' ' , 'roffset' , 1 , 'precision' , 12 );
  for i = 2:Nx
    dlmwrite( datFileName , [ x(i,:)' , y(i,:)' , Vmag(i,:)' , Varg(i,:)' ] , '-append', 'delimiter' , ' ' , 'roffset' , 1 , 'precision' , 12 );
  end % for

  fp = fopen( gnpFileName , 'w' );
  
  fprintf( fp , 'db10( x ) = 10.0 * log10 ( abs( x )  ) \n' );
  fprintf( fp , 'load "%s"\n' , styleFileName );
  fprintf( fp , 'set terminal pngcairo enhanced fontscale 1.8 size 1280 , 700\n' );
  fprintf( fp , 'set output "%s"\n' , pngFileName );
  fprintf( fp , 'set size ratio -1\n' );
  fprintf( fp , 'set lmargin at screen 0.1\n' );
  fprintf( fp , 'set rmargin at screen 0.88\n' );
  fprintf( fp , 'set xlabel "%s"\n' , xLabel );
  fprintf( fp , 'set ylabel "%s"\n' , yLabel );
  fprintf( fp , 'set cblabel "%s" offset 0.4\n' , vLabel );  
  fprintf( fp , 'set xtic out\n' );  
  fprintf( fp , 'unset ztic\n' , vLabel );  
  fprintf( fp , 'unset key\n' , vLabel );  
   if( ~isempty( xMin ) && ~isempty( xMax ) )
    fprintf( fp , 'set xrange [%g:%g]\n' , xMin , xMax );
  end % if
  if( ~isempty( yMin ) && ~isempty( yMax ) )
    fprintf( fp , 'set yrange [%g:%g]\n' , yMin , yMax );
  end % if
  if( ~isempty( vMin ) && ~isempty( vMax ) )
    fprintf( fp , 'set cbrange [%g:%g]\n' , vMin , vMax );
  end % if
  fprintf( fp , 'set view map scale 1\n' );
  fprintf( fp , 'set samples 100, 100\n' );
  fprintf( fp , 'set isosamples 100, 100\n' );
  fprintf( fp , 'unset surface\n' );
  fprintf( fp , 'h = %g\n' , 0.6 * ( x(stepX,1) - x(1,1) ) );
  fprintf( fp , 'xf(phi) = h*cos(phi)\n' );
  fprintf( fp , 'yf(phi) = h*sin(phi)\n' );
  fprintf( fp , 'splot "%s" every %d:%d using ($1-xf($4)):($2-yf($4)):(0):(2*xf($4)):(2*yf($4)):(0.0) ti "" with vectors head size 0.05,10,30 filled lc "black"\n' , datFileName , stepX , stepY );
  fclose( fp );
  
  [ status , output ] = system( [ 'gnuplot' , ' ' , gnpFileName ] );
  [ I , map ] = imread( pngFileName , 'png' );
  figure();
  image( flipud( I ) );
   
end % function
