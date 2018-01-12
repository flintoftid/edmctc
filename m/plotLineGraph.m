function [ hf ] = plotLineGraph( lines , labels , xMin , xMax , xLabel , yMin , yMax , yLabel , tag )
%plotLineGraph - plot set of line graphs.
%
% (c) 2016-2017, Ian D. Flintoft <ian.flintoft@googlemail.com>
%
% This file is part of the Electromagnetic Diffusion Model (EDM) 
% Canonical Example Suite [Flintoft2017,flintoft2017b].
%
% The EDM Canonical Example Suite is free software: you can 
% redistribute it and/or modify it under the terms of the GNU 
% General Public License as published by the Free Software 
% Foundation, either version 3 of the License, or (at your option) 
% any later version.
%
% The EDM Canonical Example Suite is distributed in the hope that 
% it will be useful, but WITHOUT ANY WARRANTY; without even the 
% implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
% PURPOSE.  See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with  The EDM Canonical Example Suite.  If not, 
% see <http://www.gnu.org/licenses/>.
%

  baseName = fileparts( which( mfilename ) );
  pngFileName = [ tag , '.png' ];

  cols = edmcolormap(10);
  marks = { '^' , '<' , '>' , 'o' , 's' , 'x' , 'p' , '*' , 'd' , 'v' };

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
  set( hlg , 'fontSize' , 7 );
  print( '-dpng' , '-r360' , pngFileName );
  hold off;
   
end % function
