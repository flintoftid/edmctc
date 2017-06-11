function [ hf ] = plotLineGraph( lines , labels , xMin , xMax , xLabel , yMin , yMax , yLabel , tag )
  
  baseName = fileparts( which( mfilename ) );
  pngFileName = [ tag , '.png' ];

  cols = edmcolormap(10);
  marks = { '^' , '<' , '>' , 'o' , 's' , 'x' };

  hf = figure();
  colormap( edmcolormap );
  hl = [];
  for i = 1:length( lines )
    hl(i) = plot( lines{i}(:,1) , lines{i}(:,2) , 'color' , cols(i,:) , 'marker' , marks{i} , 'markerFaceColor' , cols(i,:) );
    hold on;
  end % for
  xlabel( xLabel );
  ylabel( yLabel );
  if( ~isempty( xMin ) && ~isempty( xMax ) )
    xlim( [ xMin , xMax ] );
  end % if
  if( ~isempty( yMin ) && ~isempty( yMax ) )
    ylim( [ yMin , yMax ] );
  end % if
  grid( 'on' );
  hlg = legend( hl , labels , 'location' , 'northeast' );
  print( '-dpng' , '-r360' , pngFileName );
  hold off;
   
end % function
