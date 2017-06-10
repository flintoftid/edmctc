function [ hf ] = plotHeatMap( x , y , v , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , tag )

  pngFileName = [ tag , '.png' ];

  hf = figure();
  pcolor( x , y , v );
  hold on;
  shading interp;
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

