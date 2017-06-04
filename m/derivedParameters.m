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

% Source.
srcArea = 4.0 * pi * srcRadius * srcRadius; % Surface source surface area [m^2].
srcVolume = srcArea * srcRadius / 3.0;      % Surface source volume [m^3].
xsource = [ srcX ];                         % Vector of x-coordinates of sources [m].
ysource = [ srcY ];                         % Vector of y-coordinates of sources [m].
zsource = [ srcZ ];                         % Vector of z-coordinates of sources [m].
Pt = [ srcTRP ];                            % Vector of source isotropic radiate powers [W].
srcExitance = srcTRP / srcArea;             % Surface source exitance [W/m^2].

% Wall absorption factor [-].
if( isSabine )
  wallAF = 0.25 * wallAE;
else
  wallAF = 0.5 * wallAE / ( 2.0 - wallAE );
end % if

% Wall exchange coefficient [m/s].
wallEC = c0 * wallAF;

% Partition absorption factor [-].
if( isSabine )
  partAF = 0.25 * partAE;
else
  partAF = 0.5 * partAE / ( 2.0 - partAE );
end % if

% Partition exchange coefficient [m/s].
partEC = c0 * partAF;

% Cylinder  absorption factor [-].
if( isSabine )                                
  cylAF = 0.25 * cylAE;
else
  cylAF = 0.5 * cylAE / ( 2.0 - cylAE );
end % if

% Cylinder exchange coefficient [m/s].
cylEC = c0 * cylAF;

% Hole geometry.
holeArea = holeWidth * Lz;                        % Hole area [m^2].
holeTCS = 0.25 * holeArea;                        % Hole TCS [m^2].

% Cylinder geometry.
cylXSArea = pi * cylRadius * cylRadius;           % Cylinder cross-sectional area [m^2].
cylArea = 2.0 * pi * cylRadius * Lz;              % Cylinder surface area [m^2].
cylVolume = cylXSArea * Lz;                       % Cylinder volume [m^3].

% Partition geometry.
partArea = ( 2.0 * ( Ly - holeWidth ) + partThickness ) * Lz ;               
                                                  % Partition area [m^2].
partVolume = ( Ly - holeWidth ) * partThickness * Lz;              
                                                  % Cylinder volume [m^3].

% Single cavity geometry.
V = Lx * Ly * Lz;                                 % Cavity nominal volume [m^3].
SV = 2.0 * ( Lx * Ly + Ly * Lz + Lz * Lx );       % Cavity nominal enclosing surface area [m^2].
wallArea = SV;                                    % Actual wall surface area [m^2].
if( isCyl )
  wallArea = wallArea - 2.0 * cylXSArea;
  % V = V - cylVolume;
end % if

%if( isSrc )
%  V = V - srcVolume;
%end % if

% Single cavity EDM parameters.
wallMFP = 4.0 * V / SV;                           % Mean free-path of walls [m].
wallD = wallMFP * c0 / 3.0;                       % Diffusion coefficient of walls [m^2/s].
wallACS = wallAF * wallArea;                      % Absorption cross-section of wall [m^2].

% Partitioned cavity geometry.
Lx1 = partX - 0.5 * partThickness;                % Length of sub-cavity 1 [m].
V1 = Lx1 * Ly * Lz;                               % Sub-cavity 1 nominal volume [m^3].
SV1 = 2.0 * ( Lx1 * Ly + Ly * Lz + Lz * Lx1 );    % Sub-cavity 1 nominal enclosing surface area [m^2].
wallArea1 = SV1 - Ly * Lz + 0.5 * partThickness * Lz;                 
                                                  % Sub-cavity 1 wall area [m^2].
partArea1 = 0.5 * partArea;                       % Area of partition in sub-cavity 1 [m^2].

%if( isSrc )
%  V1 = V1 - srcVolume;
%end % if

Lx2 = Lx - partX - 0.5 * partThickness;           % Length of sub-cavity 2 [m].
V2 = Lx2 * Ly * Lz;                               % Sub-cavity 2 volume [m^3].
SV2 = 2.0 * ( Lx2 * Ly + Ly * Lz + Lz * Lx2 );    % Sub-cavity 2 nominal enclosing surface area [m^2].
wallArea2 = SV2 - Ly * Lz + 0.5 * partThickness * Lz;                 
                                                  % Sub-cavity 2 wall area [m^2].
partArea2 = 0.5 * partArea;                       % Area of partition in sub-cavity 2 [m^2].

if( isCyl )
  wallArea2 = wallArea2 - 2.0 * cylXSArea;
  % V2 = V2 - cylVolume;
end % if

% Partitioned cavity EDM parameters.
wallMFP1 = 4.0 * V1 / SV1;                        % Mean free-path of walls [m].
wallD1 = wallMFP1 * c0 / 3.0;                     % Diffusion coefficient of wall [m^2/s].
wallACS1 = wallAF * wallArea1;                    % Absorption cross-section of wall [m^2]
wallMFP2 = 4.0 * V2 / SV2;                        % Mean free-path of walls [m].
wallD2 = wallMFP2 * c0 / 3.0;                     % Diffusion coefficient of wall [m^2/s].
wallACS2 = wallAF * wallArea2;                    % Absorption cross-section of wall [m^2].
partACS1 = partAF * partArea1;                    % Absorption cross-section of partition in sub-cavity 1 [m^2].
partACS2 = partAF * partArea2;                    % Absorption cross-section of partition in sub-cavity 2 [m^2].

% Cylinder EDM parameters.
cylACS = cylAF * cylArea;                         % Cylinder absorption cross-section [m^2]. 
if( isPart )                                           
  cylMFP = 4.0 * V2 / cylArea;    
else
  cylMFP = 4.0 * V / cylArea;                        
end % if
cylD = cylMFP * c0 / 3.0;                         % Diffusion coefficient of cylinder [m/s].
 
% Energy exchange boundary conditions for aperture.
holeEC11 = 0.25 * holeTE * c0;                    % Exchange coefficient for hole - absorption in sub-cavity 1 [m/s].
holeEC22 = 0.25 * holeTE * c0;                    % Exchange coefficient for hole - absorption in sub-cavity 1 [m/s].
holeEC12 = 0.25 * holeTE * c0;                    % Exchange coefficient for hole - transmission from sub-cavity 2 to sub-cavity 1 [m/s].
holeEC21 = 0.25 * holeTE * c0;                    % Exchange coefficient for hole - transmission from sub-cavity 1 to sub-cavity 2 [m/s].

% Overall diffusivity.
if( ~isCyl && ~isPart )
  D1 = wallD;
  D2 = D1; 
elseif( isCyl && ~isPart )
  D1 = 1.0 / ( 1.0 / wallD + 1.0 / cylD );
  D2 = D1;
elseif( ~isCyl && isPart )
  D1 = wallD1;
  D2 = wallD2;
elseif( isCyl && isPart )
  D1 = wallD1;
  D2 = 1.0 / ( 1.0 / wallD2 + 1.0 / cylD ); 
end % if
