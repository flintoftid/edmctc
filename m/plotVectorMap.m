function plotVectorMap( x , y, Vx , Vy , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , tag )
 
  pngFileName = [ tag , '.png' ];

  Nx = size( x , 1 );
  Ny = size( y , 2 );
  
  Lx = x(end,1) - x(1,1);
  Ly = y(1,end) - y(1,1);
  L = min( [ Lx , Ly ] );
  dl = L / 12;
  stepX = floor( Nx / ( Lx / dl ) );
  stepY = floor( Ny / ( Ly / dl ) );
  
  hf = figure();
  colormap( edmcolormap );
  shading interp;
  axis( 'equal' );
  xlabel( xLabel );
  ylabel( yLabel );
  cquiver( x(1:stepX:end,1:stepY:end)' , y(1:stepX:end,1:stepY:end)' , Vx(1:stepX:end,1:stepY:end)' , Vy(1:stepX:end,1:stepY:end)' );
  hold on;
  if( ~isempty( xMin ) && ~isempty( xMax ) )
    xlim( [ xMin , xMax ] );
  end % if
  if( ~isempty( yMin ) && ~isempty( yMax ) )
    ylim( [ yMin , yMax ] );
  end % if
  if( ~isempty( vMin ) && ~isempty( vMax ) )
    set( gca , 'CLim' , [ vMin , vMax ] );
  end % if
  title( vLabel );
  print( '-dpng' , '-r360' , pngFileName );
  hold off;
   
end % function