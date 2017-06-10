function gnpHeatMap( x , y, v , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , tag )
  
  baseName = fileparts( which( mfilename ) );
  pngFileName = [ tag , '.png' ];
  gnpFileName = [ tag , '.gnp' ];
  datFileName = [ tag , '.dat' ];
  styleFileName = [ baseName , '/palette.gnp' ];
  
  Nx = size( x , 1 );
  Ny = size( y , 2 );

  fp = fopen( datFileName , 'w' );
  for i = 1:Nx
    dlmwrite( fp , [ x(i,:)' , y(i,:)' , v(i,:)' ] , ' ' , 'precision' , 12 );
   fprintf( fp , '\n' );
  end % for
  fclose( fp );

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
  fprintf( fp , 'set xyplane relative 0\n' );
  fprintf( fp , 'set samples 50, 50\n' );
  fprintf( fp , 'set isosamples 50, 50\n' );
  fprintf( fp , 'unset surface\n' );
  fprintf( fp , 'set style data pm3d\n' );
  fprintf( fp , 'set style function pm3d\n' );
  fprintf( fp , 'set pm3d implicit at b\n' );
  fprintf( fp , 'splot "%s" us 1:2:3 ti ""\n' , datFileName );

  fclose( fp );

  [ status , output ] = system( [ 'gnuplot' , ' ' , gnpFileName ] );
  [ I , map ] = imread( pngFileName , 'png' );
  figure();
  image( flipud( I ) );
   
end % function

