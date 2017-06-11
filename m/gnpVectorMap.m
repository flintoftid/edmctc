function gnpVectorMap( x , y, Vx , Vy , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , tag )
  
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
  
  fp = fopen( datFileName , 'w' );
  for i = 1:Nx
    dlmwrite( fp , [ x(i,:)' , y(i,:)' , Vmag(i,:)' , Varg(i,:)' ] , ' ' , 'precision' , 12 );
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
