function plotVectorMap( x , y, Vx , Vy , xMin , xMax , xLabel , yMin , yMax , yLabel , vMin , vMax , vLabel , tag )
%plotVectorMap - plot "velocity" of 2D vector field.
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
