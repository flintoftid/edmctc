%
% Kantorovich reduction.
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

% Sub-cavity 1.
zetaz1 = wallEC / D1;                                     % Vertical profile coefficient.
intZ1 = Lz + zetaz1 * Lz * Lz / 6.0;                      % Integral of Z.
intZSquared1 = Lz + zetaz1 * Lz * Lz / 3.0 + zetaz1 * zetaz1 * Lz * Lz * Lz / 30.0;
                                                          % Integral of Z^2. 
intZ2ndDerivZ1 = -zetaz1 * ( 2.0 + zetaz1 * Lz / 3.0 );   % Integral of Z d^2Z/dz^2.
redD1 = D1 * intZSquared1;                                % Reduced diffusivity [m/s].
arealLossRate1 = -D1 * intZ2ndDerivZ1;                    % Areal loss rate to floor/ceiling [/s].
redWallEC1 = intZSquared1 * wallEC;                       % Reduced side wall exchange coefficient [m^2/s].
redPartEC1 = intZSquared1 * partEC;                       % Reduced partition exchange coefficient [m^2/s].
ZHalfHeight1 = 1.0 + zetaz1 * Lz / 4.0;                   % Z at half height of cavity.

% Sub-cavity 2.
zetaz2 = wallEC / D2;                                     % Vertical profile coefficient.
intZ2 = Lz + zetaz2 * Lz * Lz / 6.0;                      % Integral of Z.
intZSquared2 = Lz + zetaz2 * Lz * Lz / 3.0 + zetaz2 * zetaz2 * Lz * Lz * Lz / 30.0;
                                                          % Integral of Z^2. 
intZ2ndDerivZ2 = -zetaz2 * ( 2.0 + zetaz2 * Lz / 3.0 );   % Integral of Z d^2Z/dz^2.
redD2 = D2 * intZSquared2;                                % Reduced diffusivity [m/s].
arealLossRate2 = -D2 * intZ2ndDerivZ2;                    % Areal loss rate due to floor/ceiling [/s].
redWallEC2 = intZSquared2 * wallEC;                       % Reduced side wall exchange coefficient [m^2/s].
redPartEC2 = intZSquared2 * partEC;                       % Reduced partition exchange coefficient [m^2/s].
ZHalfHeight2 = 1.0 + zetaz2 * Lz / 4.0;                   % Z at half height of cavity.

% Reduced cylinder exchange coefficient  [-].
redCylEC = intZSquared2 * cylEC;

% Reduced energy exchange boundary conditions for the hole [m^2/s].
redHoleEC11 = intZ1 * holeEC11;
redHoleEC12 = intZ1 * holeEC12;
redholeEC21 = intZSquared2 * holeEC21;
redHoleEC22 = intZSquared2 * holeEC22;
