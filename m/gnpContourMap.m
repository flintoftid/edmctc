function gnpContourMap( x , y, v , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , vCont , tag )
  
  baseName = fileparts( which( mfilename ) );
  pngFileName = [ tag , '.png' ];
  gnpFileName = [ tag , '.gnp' ];
  datFileName = [ tag , '.dat' ];
  contFileName = [ tag , '_contour.dat' ];
  contGeneratorScript = [ baseName , '/gnpContourGenerator.sh' ];
  styleFileName = [ baseName , '/edmcolormap.pal' ];
  
  Nx = size( x , 1 );
  Ny = size( y , 2 );

  fp = fopen( datFileName , 'w' );
  for i = 1:Nx
    dlmwrite( fp , [ x(i,:)' , y(i,:)' , v(i,:)' ] , ' ' , 'precision' , 12 );
    fprintf( fp , '\n' );
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
