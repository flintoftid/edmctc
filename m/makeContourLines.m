function [ vmin , vmax , vcont ] = makeContourLines( x )

  roundsf = @(x,n) str2num( num2str( x , n ) );

  x(isnan(x)) = [];
  q = quantile( x , [ 0.02 , 0.1 , 0.2 , 0.3 , 0.4 , 0.5 , 0.6 , 0.7 , 0.8 , 0.9 , 0.98 ] );
  vmin = q(1);
  vmax = q(end);
  vcontx = q(2:end-1);
  n1 = numel( vcontx );
  vcont = unique( roundsf( vcontx , 2 ) )
  n2 = numel( vcont );
  if( n2 < n1 )
    vcont = unique( roundsf( vcontx , 3 ) );
  end % if
  n3 = numel( vcont );
  if( n3 < n1 )
    vcont = unique( roundsf( vcontx , 4 ) );
  end % if
  n4 = numel( vcont );
  if( n4 < n1 )
    vcont = unique( roundsf( vcontx , 5 ) );
  end % if

end % function
