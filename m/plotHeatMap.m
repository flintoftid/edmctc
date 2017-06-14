function [ hf ] = plotHeatMap( x , y , v , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , tag )
%plotHeatMap - plot heat map of 2D scalar field.
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

  pngFileName = [ tag , '.png' ];

  hf = figure();
  colormap( edmcolormap );
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
  xlabel( hb , vLabel );
  print( '-dpng' , '-r360' , pngFileName );
  hold off;
  
end % function

