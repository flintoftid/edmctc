function gnpBarChart( x , y , xMin , xMax , xLabel , yMin , yMax , yLabel , tLabel , tag )
  
  baseName = fileparts( which( mfilename ) );
  pngFileName = [ tag , '.png' ];
  datFileName = [ tag , '.dat' ];
  gnpFileName = [ tag , '.gnp' ];
  styleFileName = [ baseName , '/edmcolormap.pal' ];

  fp = fopen( datFileName , 'w' );
  dlmwrite( fp , [ x(:) , y(:) ]  , ' ' , 'precision' , 12 );
  fclose( fp );   
   
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
  if( ~isempty( tLabel ) )
    fprintf( fp , 'set title "%s"\n' , tLabel );
  end % if
  fprintf( fp , 'set style fill solid border lt -1\n' );
  %fprintf( fp , 'set style histogram cluster gap 1\n' );
  %fprintf( fp , 'set style fill solid border -1\n' );
  %fprintf( fp , 'set boxwidth 0.9\n' );
  fprintf( fp , 'plot "%s" us 1:2 ti "" with boxes lw 2\n' , datFileName ); 

  fclose( fp );

  [ status , output ] = system( [ 'gnuplot' , ' ' , gnpFileName ] );
  [ I , map ] = imread( pngFileName , 'png' );
  figure();
  image( flipud( I ) );
   
end % function

