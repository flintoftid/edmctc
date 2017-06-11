function [ hf ] = plotBarChart( x , y , xMin , xMax , xLabel , yMin , yMax , yLabel , tLabel , tag )
  
  baseName = fileparts( which( mfilename ) );
  pngFileName = [ tag , '.png' ];

  hf = figure();
  colormap( edmcolormap );
  bar( x , y );
  xlabel( xLabel );
  ylabel( yLabel );
  if( ~isempty( xMin ) && ~isempty( xMax ) )
    xlim( [ xMin , xMax ] );
  end % if
  if( ~isempty( yMin ) && ~isempty( yMax ) )
    ylim( [ yMin , yMax ] );
  end % if
  if( ~isempty( tLabel ) )
    title( tLabel );
  end % if
  print( '-dpng' , '-r360' , pngFileName );
  hold off;

end % function
