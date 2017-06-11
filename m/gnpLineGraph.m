function gnpLineGraph( lines , labels , xMin , xMax , xLabel , yMin , yMax , yLabel , tag )
  
  baseName = fileparts( which( mfilename ) );
  pngFileName = [ tag , '.png' ];
  gnpFileName = [ tag , '.gnp' ];
  styleFileName = [ baseName , '/edmcolormap.pal' ];

  for i = 1:length( lines )
    fp = fopen( sprintf( '%s_%d.dat' , tag , i )  , 'w' );
    dlmwrite( fp , lines{i} , ' ' , 'precision' , 12 );
    fprintf( fp , '\n' );
   fclose( fp );   
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
  
  fprintf( fp , 'plot "%s" us 1:2 ti "%s" with lines ls %d lw 3\\\n' , sprintf( '%s_%d.dat' , tag , 1 ) , labels{1} , 1 ); 
  for i = 2:length( lines )
    fprintf( fp , '   , "%s" us 1:2 ti "%s" with lines ls %d lw 3\\\n' , sprintf( '%s_%d.dat' , tag , i ) , labels{i} , i );
  end % for
  fprintf( fp , '\n' );
  fclose( fp );

  [ status , output ] = system( [ 'gnuplot' , ' ' , gnpFileName ] );
  [ I , map ] = imread( pngFileName , 'png' );
  figure();
  image( flipud( I ) );
   
end % function

