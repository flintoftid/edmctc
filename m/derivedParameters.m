%
% Calculate derived parameters.
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
% References:
%
% [Flintoft2017] I D Flintoft, A C Marvin, F I Funn, L Dawson, X Zhang,
% M P Robinson, and J F Dawson, "Evaluation of the diffusion equation for
% modelling reverberant electromagnetic fields", IEEE Transactions on Electromagnetic
% Compatibility, vol. 59, no. 3, pp. 760–769, 2017. DOI: 10.1109/TEMC.2016.2623356.
%
% [Flintoft2017b] I D Flintoft and J F Dawson, “3D electromagnetic diffusion models 
% for reverberant environments”, 2017 International Conference on Electromagnetics 
% in Advanced Applications (ICEAA2017), Verona, Italy, pp. 11-15 Sep. 2017.
%

% Location for reporting observations.
obsX0 = Lx / 2;
obsY0 = Ly / 2;
obsZ0 = Lz / 2;
obsX1 = partX / 2;
obsY1 = Ly / 2;
obsZ1 = Lz / 2;
obsX2 = partX + partThickness + 3 * ( Lx - partX - partThickness ) / 4; 
obsY2 = Ly / 2;
obsZ2 = Lz / 2;

% Source.
srcArea = 4.0 * pi * srcRadius * srcRadius;           % Surface source surface area [m^2].
srcVolume = srcArea * srcRadius / 3.0;                % Surface source volume [m^3].
srcPerimeter = 2.0 * pi * srcRadius;                  % Surface source perimeter [m].
srcXSArea = pi * srcRadius * srcRadius;               % Surface source cross-sectional area [m^2].

% Hole.
holeArea = holeWidth * Lz;                            % Hole area [m^2].

% Partition.
partArea = ( 2.0 * ( Ly - holeWidth ) + partThickness ) * Lz ;               
                                                      % Partition area [m^2].
% Cylinder.
cylPerimeter = 2.0 * pi * cylRadius;                  % Cylinder perimeter [m].
cylXSArea = pi * cylRadius * cylRadius;               % Cylinder cross-sectional area [m^2].
cylArea = cylPerimeter * Lz;                          % Cylinder surface area [m^2].
cylVolume = cylXSArea * Lz;                           % Cylinder volume [m^3].

% Single cavity - cavity 0.
cavityVolume0 = Lx * Ly * Lz;                         % Cavity volume [m^3].
wallArea0 = 2.0 * ( Lx * Ly + Ly * Lz + Lz * Lx );    % Area of cavity walls [m^2].
cavityArea0 = wallArea0;                              % Total cavity boundary area [m^2].
if( isCyl )
  wallArea0 = wallArea0 - 2.0 * cylXSArea;
  cavityArea0 = cavityArea0 - 2.0 * cylXSArea + cylArea;
  cavityVolume0 = cavityVolume0 - cylVolume;
end % if
if( isSrc )
  cavityArea0 = cavityArea0 + srcArea;
  cavityVolume0 = cavityVolume0 - srcVolume;
end % if

% Partitioned cavity - sub-cavity 1.
Lx1 = partX - 0.5 * partThickness;                    % Length of sub-cavity 1 [m].
cavityVolume1 = Lx1 * Ly * Lz + 0.5 * partThickness * holeWidth * Lz;
                                                      % Sub-cavity 1 volume [m^3].
wallArea1 = 2.0 * ( Lx1 * Ly + Ly * Lz + Lz * Lx1 ) + 0.5 * partThickness * Lz; 
                                                      % Area of sub-cavity 1 walls [m^2].
partArea1 = 0.5 * partArea;                           % Area of partition in sub-cavity 1 [m^2].
cavityArea1 = wallArea1 + partArea1 + holeArea;       % Total sub-cavity 1 boundary area [m^2].
if( isSrc )
  cavityArea1 = cavityArea1 + srcArea;
  cavityVolume1 = cavityVolume1 - srcVolume;
end % if

% Partitioned cavity - sub-cavity 2.
Lx2 = Lx - Lx1 - partThickness;                       % Length of sub-cavity 2 [m].
cavityVolume2 = Lx2 * Ly * Lz + 0.5 * partThickness * holeWidth * Lz;
                                                      % Sub-cavity 2 volume [m^3].
wallArea2 = 2.0 * ( Lx2 * Ly + Ly * Lz + Lz * Lx2 ) + 0.5 * partThickness * Lz; 
                                                      % Area of sub-cavity 2 walls [m^2].
partArea2 = 0.5 * partArea;                           % Area of partition in sub-cavity 2 [m^2].
cavityArea2 = wallArea2 + partArea2 + holeArea;       % Total sub-cavity 2 boundary area [m^2].
if( isCyl )
  wallArea2 = wallArea2 - 2.0 * cylXSArea;
  cavityArea2 = cavityArea2 - 2.0 * cylXSArea + cylArea;
  cavityVolume2 = cavityVolume2 - cylVolume;
end % if
