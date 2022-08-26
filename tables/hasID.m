function [y,ID_name] = hasID(T,nv)
%HASID Summary of this function goes here
%   Detailed explanation goes here
arguments
    T;
    nv.Key = []; %'ID';
end

if isempty(nv.Key)
    nv.Key = 'ID'; % unfinished function. I will add regexp
end
ID_name = nv.Key;
y = ismember(nv.Key, T.Properties.VariableNames);

end

