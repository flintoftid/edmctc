%
% Calculate statistical energy analysis parameters for the electromagnetic diffusion model.
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

% Single cavity.
wallMFP0 = 4.0 * cavityVolume0 / cavityArea0;     % Mean free-path of walls [m].
wallD0 = wallMFP0 * c0 / 3.0;                     % Diffusion coefficient of walls [m^2/s].
wallACS0 = wallAF * wallArea0;                    % Absorption cross-section of wall [m^2].

% Partitioned cavity - sub-cavity 1.
wallMFP1 = 4.0 * cavityVolume1 / cavityArea1;     % Mean free-path of walls [m].
wallD1 = wallMFP1 * c0 / 3.0;                     % Diffusion coefficient of wall [m^2/s].
wallACS1 = wallAF * wallArea1;                    % Absorption cross-section of wall [m^2].
partACS1 = partAF * partArea1;                    % Absorption cross-section of partition in sub-cavity 1 [m^2].

% Partitioned cavity - sub-cavity 2.
wallMFP2 = 4.0 * cavityVolume2 / cavityArea2;     % Mean free-path of walls [m].
wallD2 = wallMFP2 * c0 / 3.0;                     % Diffusion coefficient of wall [m^2/s].
wallACS2 = wallAF * wallArea2;                    % Absorption cross-section of wall [m^2].
partACS2 = partAF * partArea2;                    % Absorption cross-section of partition in sub-cavity 2 [m^2].

% Hole.
holeTCS = 0.25 * holeArea;                        % Hole transmission cross-section [m^2].
holeEC11 = 0.25 * c0 * holeTE;                    % Exchange coefficient for hole - absorption in sub-cavity 1 [m/s].
holeEC22 = 0.25 * c0 * holeTE;                    % Exchange coefficient for hole - absorption in sub-cavity 1 [m/s].
holeEC12 = 0.25 * c0 * holeTE;                    % Exchange coefficient for hole - transmission from sub-cavity 2 to sub-cavity 1 [m/s].
holeEC21 = 0.25 * c0 * holeTE;                    % Exchange coefficient for hole - transmission from sub-cavity 1 to sub-cavity 2 [m/s].

% Cylinder.
if( isSabine )                                    % Cylinder  absorption factor [-].                       
  cylAF = 0.25 * cylAE;
else
  cylAF = 0.5 * cylAE / ( 2.0 - cylAE );
end % if
cylEC = c0 * cylAF;                               % Cylinder exchange coefficient [m/s].
cylMFP0 = 4.0 * cavityVolume0 / cylArea;          % Mean free-path of cylinder without partition [m].
cylMFP2 = 4.0 * cavityVolume2 / cylArea;          % Mean free-path of cylinder with partition [m].
cylD0 = cylMFP0 * c0 / 3.0;                       % Diffusion coefficient of cylinder without partition [m/s].
cylD2 = cylMFP2 * c0 / 3.0;                       % Diffusion coefficient of cylinder with partition [m/s].
cylACS = cylAF * cylArea;                         % Cylinder absorption cross-section [m^2]. 

% Soure.
srcSurfaceExitance = srcTRP / srcArea;            % Surface source exitance [W/m^2].
srcLineExitance = srcTRP / srcPerimeter;          % Line source exitance [W/m].
srcVolumetricPowerDensity = srcTRP / srcVolume;   % Volume source volumetric power density [W/m^3].
srcArealPowerDensity = srcTRP / srcXSArea;        % Area source areal power density [W/m^2].

%
% Overall diffusivity.
%

% D0 - Diffusivity in single cavity.
% D1 - Diffusivity for x <= partX in single and dual cavities.
% D2 - Diffusivity for x > partX in single and dual cavities.

if( ~isCyl && ~isPart )
  D0 = wallD0;
  D1 = D0;
  D2 = D0;
elseif( isCyl && ~isPart )
  D0 = 1.0 / ( 1.0 / wallD0 + 1.0 / cylD0 );
  D1 = D0;
  D2 = D0;
elseif( ~isCyl && isPart )
  D1 = wallD1;
  D2 = wallD2;
elseif( isCyl && isPart )
  D1 = wallD1;
  D2 = 1.0 / ( 1.0 / wallD2 + 1.0 / cylD2 ); 
end % if
