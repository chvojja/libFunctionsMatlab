function y = newID(T,nv)
%HASID Summary of this function goes here
%   Detailed explanation goes here
arguments
    T;
    nv.Key = [];
end
if isempty(nv.Key)
    [hid,nv.Key] = hasID(T);
else
    [hid,nv.Key] = hasID(T,nv.Key);
end

if hid
    y = max(T.(nv.Key)) + 1;
    if isnan(y), y = 1; end;
end

end

