%
% 3D single domain plots.
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

cols = lines(6);       % Line colors.
MS = 4;                % Marker size.
LW = 1;                % Line width.
FS = 12;               % Font size.
t = linspace(0,1,100); % Line parameter.

% PDFs of average power density over volume.
if( isPart )

  figure();
  [ nn , aa ] = hist( Sr(idx1) );
  bar( aa , nn ./ trapz( aa , nn) );
  m = nanmean( Sr(idx1) );
  sd = nanstd( Sr(idx1) );
  cv = 100 * sd / m;
  xlabel( 'Average power density (W/m^2)' , 'fontSize' , FS );
  ylabel( 'Probability density (m^2/W)' , 'fontSize' , FS );
  title( sprintf( 'EDM: %0.3f W/m^2 (CV %.2f %%), PWB: %.3f W/m^2' , m , cv , S1pwb ) );
  print( '-dpng' , '-r360' , 'S1r_PDF.png' );

  figure();
  [ nn , aa ] = hist( Sr(idx2) );
  bar( aa , nn ./ trapz( aa , nn) );
  m = nanmean( Sr(idx2) );
  sd = nanstd( Sr(idx2) );
  cv = 100 * sd / m;
  xlabel( 'Average power density (W/m^2)' , 'fontSize' , FS );
  ylabel( 'Probability density (m^2/W)' , 'fontSize' , FS );
  title( sprintf( 'EDM: %0.3f W/m^2 (CV %.2f %%), PWB: %.3f W/m^2' , m , cv , S2pwb ) );
  print( '-dpng' , '-r360' , 'S2r_PDF.png' ); 
  
else

  figure();
  [ nn , aa ] = hist( Sr(idx) );
  bar( aa , nn ./ trapz( aa , nn) );
  m = nanmean( Sr(idx) );
  sd = nanstd( Sr(idx) );
  cv = 100 * sd / m;
  xlabel( 'Average power density (W/m^2)' , 'fontSize' , FS );
  ylabel( 'Probability density (m^2/W)' , 'fontSize' , FS );
  title( sprintf( 'EDM: %0.3f W/m^2 (CV %.2f %%), PWB: %.3f W/m^2' , m , cv , Spwb ) );
  print( '-dpng' , '-r360' , 'Sr_PDF.png' );

end % if

% Profiles of power density along z. 
figure();
hl1 = plot( zz , db10( squeeze( Z(90,25,:) ./ Z(90,25,25) ) ) , '-s' , 'lineWidth' , 2*LW , 'markerSize' , MS , 'color' , cols(1,:) , 'markerFaceColor' , cols(1,:) );
hold on;
hl2 = plot( zz , db10( squeeze( w(90,25,:) ) / w(90,25,25) ) , '-o' , 'lineWidth' , LW , 'markerSize' , MS , 'color' , cols(2,:) , 'markerFaceColor' , cols(2,:) );
hl3 = plot( zz , db10( squeeze( w(50,25,:) ) / w(50,25,25) ) , '-<' , 'lineWidth' , LW , 'markerSize' , MS , 'color' , cols(3,:) , 'markerFaceColor' , cols(3,:) );
hl4 = plot( zz , db10( squeeze( w(40,25,:) ) / w(40,25,25) ) , '-<' , 'lineWidth' , LW , 'markerSize' , MS , 'color' , cols(4,:) , 'markerFaceColor' , cols(4,:) );
hl5 = plot( zz , db10( squeeze( w(30,25,:) ) / w(30,25,25) ) , '-d' , 'lineWidth' , LW , 'markerSize' , MS , 'color' , cols(5,:) , 'markerFaceColor' , cols(5,:) );
hl6 = plot( zz , db10( squeeze( w(20,25,:) ) / w(20,25,25) ) , '-^' , 'lineWidth' , LW , 'markerSize' , MS , 'color' , cols(6,:) , 'markerFaceColor' , cols(6,:) );
xlim( [ 0.0 , 0.45 ] );
ylim( [ -0.15 , 0.15 ] );
grid( 'on' );
hxl = xlabel( 'z (m)' , 'fontName' , 'Helvetica' , 'fontSize' , FS );
hyl = ylabel( 'w(x,L_y/2,z) / w(x,L_y/2,L_z/2) (dB)' , 'fontName' , 'Helvetica' , 'fontSize' , FS );
hlg = legend( [ hl1 , hl2 , hl3 , hl4 , hl5 , hl6 ] , ...
              'Kantorovich anztaz' , ...
              sprintf( 'x = %.2f m' , xx(90) ) , ...
              sprintf( 'x = %.2f m' , xx(50) ) , ...
              sprintf( 'x = %.2f m' , xx(40) ) , ...
              sprintf( 'x = %.2f m' , xx(30) ) , ...
              sprintf( 'x = %.2f m' , xx(20) ) , ...
              'location' , 'northeast' );
set( hlg , 'FontName' , 'Helvetica' , 'FontSize' , FS );
legend( 'boxoff' );
set( gca , 'fontName' , 'Helvetica' , 'fontSize' , FS );
print( '-dpng' , '-r360' , 'zprofile.png' );
hold off;

% Profiles of power density along x.
if( isPart )
  SS = S1pwb .* ( xx <= partX ) + S2pwb .* ( xx > partX );   
else
  SS = Spwb .* ones( size( xx ) );    
end % if

figure();
hl1 = plot( xx , db10( squeeze( Sr(:,5,25) ) ) , '-' , 'lineWidth' , LW , 'markerSize' , MS , 'color' , cols(1,:) , 'markerFaceColor' , cols(2,:) );
hold on;
hl2 = plot( xx , db10( squeeze( Sr(:,10,25) ) ) , '-' , 'lineWidth' , LW , 'markerSize' , MS , 'color' , cols(2,:) , 'markerFaceColor' , cols(3,:) );
hl3 = plot( xx , db10( squeeze( Sr(:,15,25) ) ) , '-' , 'lineWidth' , LW , 'markerSize' , MS , 'color' , cols(3,:) , 'markerFaceColor' , cols(4,:) );
hl4 = plot( xx , db10( squeeze( Sr(:,20,25) ) ) , '-' , 'lineWidth' , LW , 'markerSize' , MS , 'color' , cols(4,:) , 'markerFaceColor' , cols(5,:) );
hl5 = plot( xx , db10( SS )                     , '-' , 'lineWidth' , LW , 'markerSize' , MS , 'color' , cols(6,:) , 'markerFaceColor' , cols(5,:) );
xlim( [ 0.0 , 0.90 ] );
%ylim( [ 0 , 25 ] );
grid( 'on' );
hxl = xlabel( 'Position, x (m)' );
hyl = ylabel( 'S(x,L_y/2,L_z/2) (dB W/m^2)' );
hlg = legend( [ hl1 , hl2 , hl3 , hl4 , hl5 ] , ...
              sprintf( 'x = %.2f m' , yy(5)  ) , ...
              sprintf( 'x = %.2f m' , yy(10) ) , ...
              sprintf( 'x = %.2f m' , yy(15) ) , ...
              sprintf( 'x = %.2f m' , yy(20) ) , ...
              'PWB' , ...
              'location' , 'northeast' );
print( '-dpng' , '-r360' , 'xprofile.png' );
hold off;

% Power density map in plane z = Lz / 2.
kc = floor( Nz / 2 );
x_2D = squeeze( x(:,:,kc) );
y_2D = squeeze( y(:,:,kc) );
z_2D = squeeze( z(:,:,kc) );
SrdB_2D = 10 .* log10( squeeze( Sr(:,:,kc) ) );
idxNotSrc = find( ( x_2D - srcX ).^2 + ( y_2D - srcY ).^2 + ( z_2D - srcZ ).^2 >= (3 * srcRadius)^2 ); 
Smin = nanmin( SrdB_2D(idxNotSrc) );
Smax = nanmax( SrdB_2D(idxNotSrc) );
Srange = linspace( Smin , Smax , 10 );
%Srange = roundsf( Srange , 2 );

figure();
if( isOctave() )
  colormap( 'jet' );
else
  colormap( 'parula' );
end % if
pcolor( x_2D , y_2D , SrdB_2D );
hold on;
shading interp;
[ C , h ] = contour( x_2D , y_2D , SrdB_2D , Srange , 'lineColor' , 'k' );
axis( 'equal' );
xlabel( 'x (m)' , 'fontSize' , FS );
ylabel( 'y (m)' , 'fontSize' , FS );
clabel( C , h , 'fontSize' , FS );
set( gca , 'fontSize' , FS );
set( gca , 'CLim' , [ Smin , Smax ] );
hb = colorbar( 'southoutside' );
ylabel( hb , 'Power density (dB W/m^2)' , 'fontSize' , FS );
line( Lx .* t , 0.0 .* t      , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( Lx .* t , Ly + 0.0 .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( 0.0 .* t , Ly .* t      , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( Lx + 0.0 .* t , Ly .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
if( isCyl )
  line( cylX + cylRadius .* cos(2.0.*pi.*t) , cylY + cylRadius .* sin(2.0.*pi.*t) , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
end %if
if( isPart )
  line( partX + 0.0 .* t , Ly .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
end % if
print( '-dpng' , '-r360' , 'SrdB.png' );
hold off;

% Uniformity map in plane z = Lz / 2.
kc = floor( Nz / 2 );
x_2D = squeeze( x(:,:,kc) );
y_2D = squeeze( y(:,:,kc) );
z_2D = squeeze( z(:,:,kc) );
DeltadB_2D = squeeze( DeltadB(:,:,kc) );
idxNotSrc = find( ( x_2D - srcX ).^2 + ( y_2D - srcY ).^2 + ( z_2D - srcZ ).^2 >= (3 * srcRadius)^2 ); 
Dmin = nanmin( DeltadB_2D(idxNotSrc) );
Dmax = nanmax( DeltadB_2D(idxNotSrc) );
Drange = linspace( Dmin ,  Dmax , 10 );
%Drange = roundsf( Drange , 2 );

figure();
if( isOctave() )
  colormap( 'jet' );
else
  colormap( 'parula' );
end % if
pcolor( x_2D , y_2D , DeltadB_2D );
hold on;
shading interp;
[ C , h ] = contour( x_2D , y_2D , DeltadB_2D , Drange , 'lineColor' , 'k' );
axis( 'equal' );
xlabel( 'x (m)' , 'fontSize' , FS );
ylabel( 'y (m)' , 'fontSize' , FS );
clabel( C , h , 'fontSize' , FS );
set( gca , 'fontSize' , FS );
set( gca , 'CLim' , [ Dmin , Dmax ] );
hb = colorbar( 'southoutside' );
ylabel( hb , 'Uniformity (dB)' , 'fontSize' , FS );
line( Lx .* t , 0.0 .* t      , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( Lx .* t , Ly + 0.0 .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( 0.0 .* t , Ly .* t      , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( Lx + 0.0 .* t , Ly .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
if( isCyl )
  line( cylX + cylRadius .* cos(2.0.*pi.*t) , cylY + cylRadius .* sin(2.0.*pi.*t) , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
end %if
if( isPart )
  line( partX + 0.0 .* t , Ly .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
end % if
print( '-dpng' , '-r360' , 'Delta.png' );
hold off;

% Energy density flux map in plane z = Lz / 2.
kc = floor( Nz / 2 );
x_2D = squeeze( x(:,:,kc) );
y_2D = squeeze( y(:,:,kc) );
Jx_2D = squeeze( Jx(:,:,kc) );
Jy_2D = squeeze( Jy(:,:,kc) );
JdB_2D = squeeze( JdB(:,:,kc) );
idxNotSrc = find( ( x_2D - srcX ).^2 + ( y_2D - srcY ).^2 + ( z_2D - srcZ ).^2 >= (3 * srcRadius)^2 ); 
Jmin = nanmin( JdB_2D(idxNotSrc) );
Jmax = nanmax( JdB_2D(idxNotSrc) );
Jrange = linspace( Jmin ,  Jmax , 10 );
%Jrange = roundsf( Jrange , 2 );

figure();
if( isOctave() )
  colormap( 'jet' );
else
  colormap( 'parula' );
end % if
pcolor( x_2D , y_2D , JdB_2D );
hold on;
shading interp;
axis( 'equal' );
xlabel( 'x (m)' , 'fontSize' , FS );
ylabel( 'y (m)' , 'fontSize' , FS );
%hq = quiver( xJ(1:10:end) , yJ(1:10:end) , Jx(1:10:end) , Jy(1:10:end) );
%set( hq , 'AutoScaleFactor' , 1.0 , 'lineWidth' , 1 );
cquiver( x_2D(1:5:end,1:5:end)' , y_2D(1:5:end,1:5:end)' , Jx_2D(1:5:end,1:5:end)' , Jy_2D(1:5:end,1:5:end)' );
set( gca , 'fontSize' , FS );
set( gca , 'CLim' , [ Jmin , Jmax ] );
hb = colorbar( 'southoutside' );
ylabel( hb , 'Energy density flux (dB W/m^2)' , 'fontSize' , FS );
line( Lx .* t , 0.0 .* t      , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( Lx .* t , Ly + 0.0 .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( 0.0 .* t , Ly .* t      , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( Lx + 0.0 .* t , Ly .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
if( isCyl )
  line( cylX + cylRadius .* cos(2.0.*pi.*t) , cylY + cylRadius .* sin(2.0.*pi.*t) , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
end %if
if( isPart )
  line( partX + 0.0 .* t , Ly .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
end % if
print( '-dpng' , '-r360' , 'J.png' );
hold off;

% Anisotropy  map in plane z = Lz / 2.
kc = floor( Nz / 2 );
x_2D = squeeze( x(:,:,kc) );
y_2D = squeeze( y(:,:,kc) );
UpsilondB_2D = squeeze( UpsilondB(:,:,kc) );
idxNotSrc = find( ( x_2D - srcX ).^2 + ( y_2D - srcY ).^2 + ( z_2D - srcZ ).^2 >= (3 * srcRadius)^2 ); 
Umin = nanmin( UpsilondB_2D(idxNotSrc) );
Umax = nanmax( UpsilondB_2D(idxNotSrc) );
Urange = linspace( Umin ,  Umax , 10 );
%Urange = roundsf( Urange , 2 );

figure();
if( isOctave() )
  colormap( 'jet' );
else
  colormap( 'parula' );
end % if
pcolor( x_2D , y_2D , UpsilondB_2D );
hold on;
shading interp;
idx1 = find( xx <= partX );
idx2 = find( xx > partX );
[ C1 , h1 ] = contour( x_2D(idx1,:) , y_2D(idx1,:) , UpsilondB_2D(idx1,:) , Urange ,  'lineColor' , 'k' );
[ C2 , h2 ] = contour( x_2D(idx2,:) , y_2D(idx2,:) , UpsilondB_2D(idx2,:) , Urange ,  'lineColor' , 'k' );
axis( 'equal' );
xlim( [ 0 , Lx ] );
ylim( [ 0 , Ly ] );
xlabel( 'x (m)' , 'fontSize' , FS );
ylabel( 'y (m)' , 'fontSize' , FS );
clabel( C1 , h1 , 'fontSize' , FS );
clabel( C2 , h2 , 'fontSize' , FS );
set( gca , 'fontSize' , FS );
set( gca , 'CLim' , [ Umin , Umax ] );
hb = colorbar( 'southoutside' );
ylabel( hb , 'Anisotropy (dB)' , 'fontSize' , FS );
line( Lx .* t , 0.0 .* t      , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( Lx .* t , Ly + 0.0 .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( 0.0 .* t , Ly .* t      , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
line( Lx + 0.0 .* t , Ly .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
if( isCyl )
  line( cylX + cylRadius .* cos(2.0.*pi.*t) , cylY + cylRadius .* sin(2.0.*pi.*t) , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
end %if
if( isPart )
  line( partX + 0.0 .* t , Ly .* t , 'lineWidth' , 2 , 'color' , 'black' , 'lineStyle' , ':' );
end % if
print( '-dpng' , '-r360' , 'Upsilon.png' );
hold off;
