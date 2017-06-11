%
% 3D plots using Octave directly.
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

db10 = @(x) 10 .* log10( x );

% PDFs of average power density over volume.
if( isPart )

  [ nn , aa ] = hist( Sr(idx1) );
  plotBarChart( aa , nn ./ trapz( aa , nn ) , [] , [] , 'Average power density (W/m^2)' , [] , [] , 'Probability density (m^2/W)' , [] , 'PowerDensityPDF1' );
   
  [ nn , aa ] = hist( Sr(idx2) );
  plotBarChart( aa , nn ./ trapz( aa , nn ) , [] , [] , 'Average power density (W/m^2)' , [] , [] , 'Probability density (m^2/W)' , [] , 'PowerDensityPDF2' );
    
else

  [ nn , aa ] = hist( Sr );
  plotBarChart( aa , nn ./ trapz( aa , nn ) , [] , [] , 'Average power density (W/m^2)' , [] , [] , 'Probability density (m^2/W)' , [] , 'PowerDensityPDF' );

end % if

% Profiles of power density along z. 
clear lines labels
lines{1} = [ zz(1:2:end) , db10( squeeze( Z(90,25,1:2:end) ./ Z(90,25,25) ) ) ];
lines{2} = [ zz(1:2:end) , db10( squeeze( w(90,25,1:2:end) ./ w(90,25,25) ) ) ];
lines{3} = [ zz(1:2:end) , db10( squeeze( w(50,25,1:2:end) ./ w(50,25,25) ) ) ];
lines{4} = [ zz(1:2:end) , db10( squeeze( w(40,25,1:2:end) ./ w(40,25,25) ) ) ];
lines{5} = [ zz(1:2:end) , db10( squeeze( w(30,25,1:2:end) ./ w(30,25,25) ) ) ];
lines{6} = [ zz(1:2:end) , db10( squeeze( w(20,25,1:2:end) ./ w(20,25,25) ) ) ];
labels{1} = 'Kantorovich anztaz';
labels{2} = sprintf( 'x = %.2f m' , xx(90) );
labels{3} = sprintf( 'x = %.2f m' , xx(50) );
labels{4} = sprintf( 'x = %.2f m' , xx(40) );
labels{5} = sprintf( 'x = %.2f m' , xx(30) );
labels{6} = sprintf( 'x = %.2f m' , xx(20) );

plotLineGraph( lines , labels , 0.0 , 0.45 , '{/Helvetica-Italic z} (m)' , [] , [] , '{/Helvetica-Italic S}({/Helvetica-Italic L_x}/2,{/Helvetica-Italic L_y}/2,{/Helvetica-Italic z}) (dB W/m^2)' , 'PowerDensityProfileZ' );

% Profiles of power density along x.
if( isPart )
  SS = S1pwb .* ( xx <= partX ) + S2pwb .* ( xx > partX );   
else
  SS = Spwb .* ones( size( xx ) );    
end % if

clear lines labels
lines{1} = [ xx(1:2:end) , db10( squeeze( Sr(1:2:end,5,25) ) ) ];
lines{2} = [ xx(1:2:end) , db10( squeeze( Sr(1:2:end,10,25) ) ) ];
lines{3} = [ xx(1:2:end) , db10( squeeze( Sr(1:2:end,15,25) ) ) ];
lines{4} = [ xx(1:2:end) , db10( squeeze( Sr(1:2:end,20,25) ) ) ];
lines{5} = [ xx(1:2:end) , db10( SS(1:2:end) ) ];
labels{1} = sprintf( 'x = %.2f m' , yy(5) );
labels{2} = sprintf( 'x = %.2f m' , yy(10) );
labels{3} = sprintf( 'x = %.2f m' , yy(15) );
labels{4} = sprintf( 'x = %.2f m' , yy(20) );
labels{5} = 'PWB';

plotLineGraph( lines , labels , 0.0 , 0.9 , '{/Helvetica-Italic x} (m)' , [] , [] , '{/Helvetica-Italic S}({/Helvetica-Italic x},{/Helvetica-Italic L_y}/2,{/Helvetica-Italic L_z}/2) (dB W/m^2)' , 'PowerDensityProfileX' );

% Power density map in plane z = Lz / 2.
kc = floor( Nz / 2 );
x_2D = squeeze( x(:,:,kc) );
y_2D = squeeze( y(:,:,kc) );
SrdB_2D = db10( squeeze( Sr(:,:,kc) ) );
idxNotSrc = find( ( x_2D - srcX ).^2 + ( y_2D - srcY ).^2 >= (3 * srcRadius)^2 ); 
SrdB_2D_min = nanmin( SrdB_2D(idxNotSrc) );
SrdB_2D_max = nanmax( SrdB_2D(idxNotSrc) );
SrdB_2D_cont = linspace( SrdB_2D_min , SrdB_2D_max , 10 );
SrdB_2D_cont = roundsf( SrdB_2D_cont , 2 );

plotContourHeatMap( x_2D , y_2D, SrdB_2D , ...
                    0.0 , 0.9 , '{/Helvetica-Italic x} (m)' , ...
                    0.0 , 0.45 , '{/Helvetica-Italic y} (m)' , ...
                    SrdB_2D_min , SrdB_2D_max , 'Power density, {/Helvetica-Italic S} (dB W/m^2)' , SrdB_2D_cont , 'PowerDensityMap' );

% Uniformity map in plane z = Lz / 2.
kc = floor( Nz / 2 );
x_2D = squeeze( x(:,:,kc) );
y_2D = squeeze( y(:,:,kc) );
DeltadB_2D = squeeze( DeltadB(:,:,kc) );
idxNotSrc = find( ( x_2D - srcX ).^2 + ( y_2D - srcY ).^2 >= (3 * srcRadius)^2 ); 
DeltadB_2D_min = nanmin( DeltadB_2D(idxNotSrc) );
DeltadB_2D_max = nanmax( DeltadB_2D(idxNotSrc) );
DeltadB_2D_cont = linspace( DeltadB_2D_min , DeltadB_2D_max , 10 );
DeltadB_2D_cont = roundsf( DeltadB_2D_cont , 2 );

plotContourHeatMap( x_2D , y_2D, DeltadB_2D , ...
                    0.0 , 0.9 , '{/Helvetica-Italic x} (m)' , ...
                    0.0 , 0.45 , '{/Helvetica-Italic y} (m)' , ...
                    DeltadB_2D_min , DeltadB_2D_max , 'Uniformity (dB)' ,DeltadB_2D_cont , 'EnergyDensityUniformityMap' );

% Energy density flux map in plane z = Lz / 2.
kc = floor( Nz / 2 );
x_2D = squeeze( x(:,:,kc) );
y_2D = squeeze( y(:,:,kc) );
Jx_2D = squeeze( Jx(:,:,kc) );
Jy_2D = squeeze( Jy(:,:,kc) );
JdB_2D = squeeze( JdB(:,:,kc) );
idxNotSrc = find( ( x_2D - srcX ).^2 + ( y_2D - srcY ).^2 >= (3 * srcRadius)^2 ); 
JdB_2D_min = nanmin( JdB_2D(idxNotSrc) );
JdB_2D_max = nanmax( JdB_2D(idxNotSrc) );
JdB_2D_cont = linspace( JdB_2D_min ,  JdB_2D_max , 10 );
JdB_2D_cont = roundsf( JdB_2D_cont , 2 );

plotVectorHeatMap( x_2D , y_2D, Jx_2D , Jy_2D , ...
                   0.0 , 0.9 , '{/Helvetica-Italic x} (m)' , ...
                   0.0 , 0.45 , '{/Helvetica-Italic y} (m)' , ...
                   [] , [] , 'Energy density flux, |{/Helvetica-Bold-Italic J}| (dB W/m^2)' , 'EnergyDensityFluxMap' );

% Anisotropy map in plane z = Lz / 2.
kc = floor( Nz / 2 );
x_2D = squeeze( x(:,:,kc) );
y_2D = squeeze( y(:,:,kc) );
UpsilondB_2D = squeeze( UpsilondB(:,:,kc) );
idxNotSrc = find( ( x_2D - srcX ).^2 + ( y_2D - srcY ).^2 + ( z_2D - srcZ ).^2 >= (3 * srcRadius)^2 ); 
UpsilondB_2D_min = nanmin( UpsilondB_2D(idxNotSrc) );
UpsilondB_2D_max = nanmax( UpsilondB_2D(idxNotSrc) );
UpsilondB_2D_cont = linspace( UpsilondB_2D_min , UpsilondB_2D_max , 10 );
UpsilondB_2D_cont = roundsf( UpsilondB_2D_cont , 2 );

plotContourHeatMap( x_2D , y_2D, UpsilondB_2D , ...
                    0.0 , 0.9 , '{/Helvetica-Italic x} (m)' , ...
                    0.0 , 0.45 , '{/Helvetica-Italic y} (m)' , ...
                    UpsilondB_min , UpsilondB_max , 'Anisotropy (dB)' , UpsilondB_cont , 'EnergyDensityAnisotropyMap' );
colormap( 'viridis' );
