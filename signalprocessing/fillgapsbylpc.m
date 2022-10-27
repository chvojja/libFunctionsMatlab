function y = fillgapsbylpc(x,linearfill_nsamples)
%FILLGAPSBYLPC Summary of this function goes here
%   Detailed explanation goes here


x_L = isnan(x);

a = movmean( x , linearfill_nsamples) ;

x_source = x(~isnan(a))-a(~isnan(a));

a = fillgaps(a,[],1); % linearfill

x(x_L)=a(x_L);

N_fill_samples = numel( find(x_L == true) );
Ns = round(numel( x_source)/2);
x_source=x_source( Ns - round(N_fill_samples/2)+1  : Ns + round(N_fill_samples/2) -1);

% makeup some new samples
[d,p0] = lpc( x_source , N_fill_samples   );
u = sqrt(p0)*randn(length( x_source ),1); 
fill_sig = filter(1,d,u)';

x(x_L)=x(x_L) + fill_sig';



y = x;

% Nf = numel(x_L);
% for i = 1:Nf
% 
% 
% end

end

