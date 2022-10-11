function y = tocell(x)
%TOCELL 


if iscell(x)
    y = x;
else
    y = {x};
end

