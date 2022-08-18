function y = logiBin2dec(x)
% x = logical binary vector e.g . logical( [0 1 1 ] )
% y = decimal value  e.g. 3


% One solution
% [Nr,Nc]=size(x);
% Nbits=Nc;
% 
% ENbits = flip([1  2 .^(1:(Nbits-1))]);
% 
% xr=reshape(x',Nbits,Nc*Nr/Nbits)';
% yr = sum(bsxfun(@times,xr, ENbits),2);
% y = reshape(yr,Nc/Nbits,Nr)';
% Second solution
  y=bin2dec(sprintf('%i',x));

end