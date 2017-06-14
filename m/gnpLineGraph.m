function gnpLineGraph( lines , labels , xMin , xMax , xLabel , yMin , yMax , yLabel , tag )
%gnpLineGraph - plot set of line graphs using gnuplot.
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
  styleFileName = [ baseName , '/edmcolormap.pal' ];

  for i = 1:length( lines )
    dlmwrite( sprintf( '%s_%d.dat' , tag , i ) , lines{i} , 'delimiter' , ' ' , 'precision' , 12 );
  end % for
 
  fp = fopen( gnpFileName , 'w' );

  fprintf( fp , 'db10( x ) = 10.0 * log10 ( abs( x )  ) \n' );
  fprintf( fp , 'load "%s"\n' , styleFileName );
  fprintf( fp , 'set terminal pngcairo enhanced fontscale 1.0\n' );
  fprintf( fp , 'set output "%s"\n' , pngFileName );
  fprintf( fp , 'set xlabel "%s"\n' , xLabel );
  fprintf( fp , 'set ylabel "%s"\n' , yLabel );
  if( ~isempty( xMin ) && ~isempty( xMax ) )
    fprintf( fp , 'set xrange [%g:%g]\n' , xMin , xMax );
  end % if
  if( ~isempty( yMin ) && ~isempty( yMax ) )
    fprintf( fp , 'set yrange [%g:%g]\n' , yMin , yMax );
  end % if
  
  fprintf( fp , 'plot "%s" us 1:2 ti "%s" with linesp ls %d lw 2 dt %d pointtype %d pointsize 1.4\\\n' , sprintf( '%s_%d.dat' , tag , 1 ) , labels{1} , 1 , 1 , 1 ); 
  for i = 2:length( lines )
    fprintf( fp , '   , "%s" us 1:2 ti "%s" with linesp ls %d lw 2 dt %d pointtype %d pointsize 1.4\\\n' , sprintf( '%s_%d.dat' , tag , i ) , labels{i} , i , i , i );
  end % for
  fprintf( fp , '\n' );
  fclose( fp );

  [ status , output ] = system( [ 'gnuplot' , ' ' , gnpFileName ] );
  [ I , map ] = imread( pngFileName , 'png' );
  figure();
  image( flipud( I ) );
   
end % function

