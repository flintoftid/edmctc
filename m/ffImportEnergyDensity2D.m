function [ x , y , w ] = ffImportEnergyDensity2D( fileName )
%ffImportEnergyDensity2D - Import 2D ASCII format energy density field.
%
% [ x , y , w ] = ffImportEnergyDensity2D( fileName )
%
% Inputs:
%
% fileName - string, name of imput file.
%
% Outputs:
%
% x - real array, x-coordinates of sampled field [m].
% y - real array, y-coordinates of sampled field [m].
% w - real array, energy density field [J/m^3].
%

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

  fpw = fopen( fileName , 'r' );

  Nx = fscanf( fpw , '%g' , [ 1 , 1 ] );
  Ny = fscanf( fpw , '%g' , [ 1 , 1 ] );

  x = zeros( Nx , Ny );
  y = zeros( Nx , Ny );
  w = zeros( Nx , Ny );

  for i = 1:Nx
    for j = 1:Ny
      x(i,j) = fscanf( fpw , '%g' , [ 1 , 1 ] );
      y(i,j) = fscanf( fpw , '%g' , [ 1 , 1 ] );
      w(i,j) = fscanf( fpw , '%g' , [ 1 , 1 ] );      
    end % for j
  end % for i

  fclose( fpw );

end % function
