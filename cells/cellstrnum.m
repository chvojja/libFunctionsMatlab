function y = cellstrnum(x)
%CELLSTRNUM Summary of this function goes here
%   Detailed explanation goes here
if ~iscell(x)
    if isnumeric(x)
        y = num2cell(x);
    else
        y = cellstr(x);
    end
   
else
    y = x;
end

