function varargout = rowfunt(nv)
%ROWFUNT runs Fun in loop
arguments
    nv.Fun;
    nv.Table;
end

[r,c] = size(nv.Table);
nrg = nargout(nv.Fun);


if nrg==0

    for i =1:r
       nv.Fun(nv.Table(i,:));
    end
else
    for i =1:r
       varargout = nv.Fun(nv.Table(i,:));
    end
end

