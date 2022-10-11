function y = loadfun(fun,flist)
%LOADFUN loads something with fun
% this is fast, use it
% flist should be list of arguments as cell array

flist = tocell(flist);
N=numel(flist);
x = cell(N,1);
for i = 1:N
    x{i} = fun(flist{i}) ;
end

if iscolumn(flist)
y = cat(1, x{:} );
else
y = cat(2, x{:} );
end


end

