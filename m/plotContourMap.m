function [ hf ] = plotContourMap( x , y , v , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , vCont , tag )

  pngFileName = [ tag , '.png' ];

  hf = figure();
  if( isempty( vCont ) )
    [ C , h ] = contour( x , y , v , 10 , 'lineColor' , 'k' );
  else
    [ C , h ] = contour( x , y , v , vCont , 'lineColor' , 'k' );
  end % if
  hold on;
  axis( 'equal' );
  xlabel( xLabel );
  ylabel( yLabel );
  if( ~isempty( xMin ) && ~isempty( xMax ) )
    xlim( [ xMin , xMax ] );
  end % if
  if( ~isempty( yMin ) && ~isempty( yMax ) )
    ylim( [ yMin , yMax ] );
  end % if
  title( vLabel );
  print( '-dpng' , '-r360' , pngFileName );
  hold off;
  
end % function

