function gnpContourMap( x , y, v , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , vCont , tag )
%gnpContourMap - plot contour map of 2D scalar field using gnuplot
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
  contFileName = [ tag , '_contour.dat' ];
  contGeneratorScript = [ baseName , '/gnpContourGenerator.sh' ];
  styleFileName = [ baseName , '/edmcolormap.pal' ];
  
  Nx = size( x , 1 );
  Ny = size( y , 2 );

  dlmwrite( datFileName ,  [ x(1,:)' , y(1,:)' , v(1,:)' ] , 'delimiter' , ' ' , 'roffset' , 1 , 'precision' , 12 );
  for i = 2:Nx
    dlmwrite( datFileName ,  [ x(i,:)' , y(i,:)' , v(i,:)' ] , '-append' , 'delimiter' , ' ' , 'roffset' , 1 , 'precision' , 12 );
  end % for
  fclose( fp );

  fp = fopen( gnpFileName , 'w' );

  if( ~isempty( xMin ) && ~isempty( xMax ) )
    fprintf( fp , 'set xrange [%g:%g]\n' , xMin , xMax );
  end % if
  if( ~isempty( yMin ) && ~isempty( yMax ) )
    fprintf( fp , 'set yrange [%g:%g]\n' , yMin , yMax );
  end % if
  fprintf( fp , 'set isosamples 150, 150\n' );  
  fprintf( fp , 'set cont base\n' );
  if( isempty( vCont ) )
    fprintf( fp , 'set cntrparam level auto\n' );
  else
    fprintf( fp , 'set cntrparam level discrete %g' , vCont(1) );
    for idx = 2:numel( vCont )
      fprintf( fp , ' , %g' , vCont(idx) );   
    end % if
   fprintf( fp , '\n' );
  end % if
  fprintf( fp , 'unset surf\n' );
  fprintf( fp , 'set table "%s"\n' , contFileName );
  fprintf( fp , 'splot "%s" us 1:2:3\n' , datFileName );
  fprintf( fp , 'unset table\n' );
  fprintf( fp , 'reset\n' );  
  fprintf( fp , 'db10( x ) = 10.0 * log10 ( abs( x )  ) \n' );
  fprintf( fp , 'load "%s"\n' , styleFileName );
  fprintf( fp , 'set terminal pngcairo enhanced fontscale 1.8 size 1280 , 700\n' );
  fprintf( fp , 'set output "%s"\n' , pngFileName );
  fprintf( fp , 'set size ratio -1\n' );
  %fprintf( fp , 'set lmargin at screen 0.1\n' );
  %fprintf( fp , 'set rmargin at screen 0.88\n' );
  fprintf( fp , 'set xlabel "%s"\n' , xLabel );
  fprintf( fp , 'set ylabel "%s"\n' , yLabel );
  fprintf( fp , 'set xtic out\n' );  
  fprintf( fp , 'unset ztic\n' , vLabel );  
  fprintf( fp , 'unset key\n' , vLabel );  
   if( ~isempty( xMin ) && ~isempty( xMax ) )
    fprintf( fp , 'set xrange [%g:%g]\n' , xMin , xMax );
  end % if
  if( ~isempty( yMin ) && ~isempty( yMax ) )
    fprintf( fp , 'set yrange [%g:%g]\n' , yMin , yMax );
  end % if
  fprintf( fp , 'load "< %s %s 0 5 1"\n' , contGeneratorScript , contFileName );  
  fprintf( fp , 'plot "< %s %s 1 5 1" w l lt -1 lw 1.5\n' ,  contGeneratorScript , contFileName ); 
  fclose( fp );
  
  [ status , output ] = system( [ 'gnuplot' , ' ' , gnpFileName ] );
  [ I , map ] = imread( pngFileName , 'png' );
  figure();
  image( flipud( I ) );
   
end % function
