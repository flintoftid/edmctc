
% Profiles of power density along x.
if( isPart )
  SS = S1pwb .* ( xx <= partX ) + S2pwb .* ( xx > partX );   
else
  SS = S0pwb .* ones( size( xx ) );    
end % if

if( ~isPart & ~isCyl )
  data = readDataFile( '../../../Vulture/S_SU_FDTD_z0000.dat' );
elseif( ~isPart & isCyl )
  data = readDataFile( '../../../Vulture/S_SL_FDTD_z0000.dat' );
elseif( isPart & ~isCyl )
  data = readDataFile( '../../../Vulture/S_DU_FDTD_z0000.dat' );
elseif( isPart & isCyl )
  data = readDataFile( '../../../Vulture/S_DL_FDTD_z0000.dat' );  
end % if
  
xx_fdtd = data(:,1);
S_y009_fdtd = data(:,2);
S_y018_fdtd = data(:,3);
S_y027_fdtd = data(:,4);
S_y036_fdtd = data(:,5);

clear lines labels
lines{1} = [ xx(1:2:end) , db10( squeeze( Sr(1:2:end,10,25) ) ) ];
lines{2} = [ xx(1:2:end) , db10( squeeze( Sr(1:2:end,20,25) ) ) ];
lines{3} = [ xx(1:2:end) , db10( squeeze( Sr(1:2:end,30,25) ) ) ];
lines{4} = [ xx(1:2:end) , db10( squeeze( Sr(1:2:end,40,25) ) ) ];
lines{5} = [ xx(1:2:end) , db10( SS(1:2:end) ) ];
lines{6} = [ xx_fdtd , db10( S_y009_fdtd ) ];
lines{7} = [ xx_fdtd , db10( S_y018_fdtd ) ];
lines{8} = [ xx_fdtd , db10( S_y027_fdtd ) ];
lines{9} = [ xx_fdtd , db10( S_y036_fdtd ) ];
labels{1} = sprintf( 'EDM, y = %.2f m' , yy(10) );
labels{2} = sprintf( 'EDM, y = %.2f m' , yy(20) );
labels{3} = sprintf( 'EDM, y = %.2f m' , yy(30) );
labels{4} = sprintf( 'EDM, y = %.2f m' , yy(40) );
labels{5} = 'PWB';
labels{6} = sprintf( 'FDTD, y = %.2f m' , 0.09 );
labels{7} = sprintf( 'FDTD, y = %.2f m' , 0.18 );
labels{8} = sprintf( 'FDTD, y = %.2f m' , 0.27 );
labels{9} = sprintf( 'FDTD, y = %.2f m' , 0.36 );

plotLineGraph( lines , labels , 0.0 , 0.9 , 'x (m)' , [] , [] , 'S(x,y,L_z/2) (dB W/m^2)' , 'PowerDensityProfileXFDTD' );
