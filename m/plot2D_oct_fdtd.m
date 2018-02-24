
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

xx_meas = data(:,1);
S_y009_meas = data(:,2);
S_y018_meas = data(:,3);
S_y027_meas = data(:,4);
S_y036_meas = data(:,5);

clear lines labels
lines{1} = [ xx(1:2:end) , db10( squeeze( S2r(1:2:end,10) ) ) ];
lines{2} = [ xx(1:2:end) , db10( squeeze( S2r(1:2:end,20) ) ) ];
lines{3} = [ xx(1:2:end) , db10( squeeze( S2r(1:2:end,30) ) ) ];
lines{4} = [ xx(1:2:end) , db10( squeeze( S2r(1:2:end,40) ) ) ];
lines{5} = [ xx(1:2:end) , db10( SS(1:2:end) ) ];
lines{6} = [ xx_meas , db10( S_y009_meas ) ];
lines{7} = [ xx_meas , db10( S_y018_meas ) ];
lines{8} = [ xx_meas , db10( S_y027_meas ) ];
lines{9} = [ xx_meas , db10( S_y036_meas ) ];
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
