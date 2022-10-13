function y = tocell(x)
%TOCELL 


if isscalar(x)
    y = {x};
    
else
    if iscategorical(x)
         y = cellstr(x);
    else
         y = x;
    end
end

