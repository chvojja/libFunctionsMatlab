function [ y, scale_factor ]  = fitrange(x,xrange)
%FITRANGE  fits a signal into the range [lo hi]


hi = xrange(2);
lo = xrange(1);
span = hi-lo;

% normalize 
xs = sort(x,'ascend');
xspan = xs(end)-xs(1);
xn=(x-xs(1))/xspan;

% scale
y =xn*span+lo;
scale_factor  = span/xspan; % number by which we have to multiply any other signal in units of x to have it consistent in y
end

