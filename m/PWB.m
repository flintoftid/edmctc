%
% Power balance (PWB) model calculation.
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

if( isPart )
  ACS1 = wallACS1 + partACS1;
  if( isCyl )
    ACS2 = wallACS2 + partACS2 + cylACS;
  else
    ACS2 = wallACS2 + partACS2;
  end % if
  det = ( ACS1 + holeTCS ) * ( ACS2 + holeTCS ) - holeTCS * holeTCS;
  S1pwb = ( ACS2 + holeTCS ) * srcTRP / det;
  S2pwb = holeTCS * srcTRP / det;
  w1pwb = S1pwb / c0;
  w2pwb = S2pwb / c0;
  fprintf( 'PWB power density in sub-cavity 1: %g W/m^2 = %g dB W/m^2\n' , S1pwb , db10( S1pwb ) );
  fprintf( 'PWB power density in sub-cavity 2: %g W/m^2 = %g dB W/m^2\n' , S2pwb , db10( S2pwb ) );  
else
  if( isCyl )
    ACS0 = wallACS0 + cylACS;
  else
    ACS0 = wallACS0; 
  end % if
  S0pwb = srcTRP / ACS;
  w0pwb = S0pwb / c0;
  fprintf( 'PWB power density in cavity: %g W/m^2 = %g dB W/m^2\n' , S0pwb , db10( S0pwb ) );
end % if
