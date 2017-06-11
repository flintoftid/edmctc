function [ hf ] = plotContourHeatMap( x , y , v , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , vCont , tag )

  pngFileName = [ tag , '.png' ];

  hf = figure();
  colormap( edmcolormap );
  pcolor( x , y , v );
  hold on;
  shading interp;
  if( isempty( vCont ) )
    [ C , h ] = contour( x , y , v , 10 , 'lineColor' , 'k' );
  else
    [ C , h ] = contour( x , y , v , vCont , 'lineColor' , 'k' );
  end % if
  axis( 'equal' );
  xlabel( xLabel );
  ylabel( yLabel );
  if( ~isempty( xMin ) && ~isempty( xMax ) )
    xlim( [ xMin , xMax ] );
  end % if
  if( ~isempty( yMin ) && ~isempty( yMax ) )
    ylim( [ yMin , yMax ] );
  end % if
  if( ~isempty( vMin ) && ~isempty( vMax ) )
    set( gca , 'CLim' , [ vMin , vMax ] );
  end % if
  hb = colorbar( 'southoutside' );
  ylabel( hb , vLabel );
  print( '-dpng' , '-r360' , pngFileName );
  hold off;
  
end % function

