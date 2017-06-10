function gnpContourMap2( x , y, v , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , vCont , tag )
  
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
  fprintf( fp , 'set isosamples 150, 150\n' );  
  fprintf( fp , 'set xyplane relative 0\n' );
  fprintf( fp , 'set style data lines\n' );
  fprintf( fp , 'set view map\n' );
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
  fprintf( fp , 'set cntrlabel onecolor format "%%8.3g" font ",7" start 2 interval 200\n' ); 
  fprintf( fp , 'set style textbox opaque margins  0.5,  0.5 noborder\n' );
  fprintf( fp , 'set hidden3d back offset 1 trianglepattern 3 undefined 1 altdiagonal bentover\n' );
  fprintf( fp , 'unset ztic\n' , vLabel );  
  fprintf( fp , 'unset key\n' , vLabel );  
  fprintf( fp , 'unset surf\n' );
  if( ~isempty( xMin ) && ~isempty( xMax ) )
    fprintf( fp , 'set xrange [%g:%g]\n' , xMin , xMax );
  end % if
  if( ~isempty( yMin ) && ~isempty( yMax ) )
    fprintf( fp , 'set yrange [%g:%g]\n' , yMin , yMax );
  end % if
  fprintf( fp , 'splot "%s" us 1:2:3 ti "" with lines lc rgb "#000000" , "%s" us 1:2:3 ti "" with labels boxed\n' , datFileName , datFileName );
  fclose( fp );

  [ status , output ] = system( [ 'gnuplot' , ' ' , gnpFileName ] );
  [ I , map ] = imread( pngFileName , 'png' );
  figure();
  image( flipud( I ) );
   
end % function
