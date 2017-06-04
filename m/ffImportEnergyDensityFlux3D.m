function [ x , y , z , Jx , Jy , Jz ] = ffImportEnergyDensityFlux3D( fileName )
%ffImportEnergyDensityFlux3D - Import 3D ASCII format energy density flux 
% vector field.
%
% [ x , y , z , Jx , Jx , Jz ] = ffImportEnergyDensity3D( fileName )
%
% Inputs:
%
% fileName - string, name of imput file.
%
% Outputs:
%
% x  - real array, x-coordinates of sampled field [m].
% y  - real array, y-coordinates of sampled field [m].
% z  - real array, z-coordinates of sampled field [m].
% Jx - real array, x-component of energy density flux vector field [W/m^2].
% Jy - real array, y-component of energy density flux vector field [W/m^2].
% Jz - real array, z-component of energy density flux vector field [W/m^2].
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

 fpJ = fopen( fileName , 'r' );

  Nx = fscanf( fpJ , '%g' , [1,1] );
  Ny = fscanf( fpJ , '%g' , [1,1] );
  Nz = fscanf( fpJ , '%g' , [1,1] );

  x = zeros( Nx , Ny , Nz );
  y = zeros( Nx , Ny , Nz );
  z = zeros( Nx , Ny , Nz );
  Jx = zeros( Nx , Ny , Nz );
  Jy = zeros( Nx , Ny , Nz );
  Jz = zeros( Nx , Ny , Nz );

  for i = 1:Nx
    for j = 1:Ny
      for k = 1:Nz
        x(i,j,k) = fscanf( fpJ , '%g' , [1,1] );
        y(i,j,k) = fscanf( fpJ , '%g' , [1,1] );
        z(i,j,k) = fscanf( fpJ , '%g' , [1,1] );      
        Jx(i,j,k) = fscanf( fpJ , '%g' , [1,1] );
        Jy(i,j,k) = fscanf( fpJ , '%g' , [1,1] );
        Jz(i,j,k) = fscanf( fpJ , '%g' , [1,1] );      
      end % for k
    end % for i
  end % for i

  fclose( fpJ );

end % function
